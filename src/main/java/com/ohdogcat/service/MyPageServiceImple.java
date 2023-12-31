package com.ohdogcat.service;

import com.ohdogcat.dto.member.MemberAddressUpdateDto;
import com.ohdogcat.dto.member.MemberChangeInfoDto;
import com.ohdogcat.dto.member.MemberInfoDto;
import com.ohdogcat.dto.wishlist.WishListDto;
import com.ohdogcat.dto.purchase.PurchaseListDto;
import com.ohdogcat.dto.purchase.PurchaseListPagenationDto;
import com.ohdogcat.model.Address;
import com.ohdogcat.model.Member;
import com.ohdogcat.repository.AddressDao;
import com.ohdogcat.repository.MemberDao;
import com.ohdogcat.repository.WishListDao;
import com.ohdogcat.repository.PurchaseDao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import java.util.List;

import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class MyPageServiceImple implements MyPageService {

    private final MemberDao memberDao;
    private final AddressDao addressDao;
    private final WishListDao wishListDao;
    private final PurchaseDao purchaseDao;

    @Override
    public MemberInfoDto getMemberMyPageInfo(Long memberPk) {
        MemberInfoDto memberInfoDto;
        Member member = memberDao.getMemberMyPageInfo(memberPk);
        memberInfoDto = MemberInfoDto.fromMember(member);

        if (member.getAddress_fk() == null) {
            return memberInfoDto;
        }

        Address memberAddress = addressDao.getAddressByAddressPk(member.getAddress_fk());
        MemberInfoDto.fromAddress(memberInfoDto, memberAddress);
        return memberInfoDto;
    }

    @Override
    public Boolean updateUserInfo(MemberChangeInfoDto dto) throws IllegalArgumentException {
        Member member = dto.toMemberToCheck();

        String phone = memberDao.getMemberPhone(member);

        log.debug(phone);

        if (phone == null) {
            throw new IllegalArgumentException("비밀번호가 일치하지 않습니다.");
        }

        log.debug("헤헤헤헤헿");
        if (phone.equals(dto.getPhone())) {
            dto.setPhone(null);
        }

        return memberDao.updateUserInfo(dto.toMemberToChange()) == 1;
    }

    @Override
    public Boolean updateUserAddress(MemberAddressUpdateDto dto) {
        log.debug("updateUserAddress(dto={})", dto);

        Address address = dto.toAddress();
        addressDao.registerAddress(address);

        Member memberToUpdateAddress = Member.builder()
            .member_pk(dto.getMember_pk())
            .address_fk(address.getAddress_pk()).build();

        Long result = memberDao.updateUserDefaultAddress(memberToUpdateAddress);

        return result == 1;
    }

    /* 유정 */
	@Override
	public List<WishListDto> getWishiList(Long memberPk) {
		List<WishListDto> wishList = wishListDao.selectWishListByMember(memberPk);
		return wishList;
	}
    @Override
    public Map<String, Object> getMemberPurchaseList(PurchaseListPagenationDto pageInfo) {
        Map<String, Object> result = new HashMap<>();

        int offset = (pageInfo.getCurPage() - 1) * 10;
        pageInfo.setOffset(offset);
        log.debug("limit={}" ,pageInfo.getLimit());
        pageInfo.setLimit(10);

        List<PurchaseListDto> purchaseList = purchaseDao.getMemberPurchaseList(pageInfo);
        result.put("purchaseList", purchaseList);

        Integer count = purchaseDao.getPurchaseCount(pageInfo.getMember_fk());
        Integer page = (int) Math.ceil(((count * 1.0) / 10));
        result.put("page", page);
        log.debug("page={}", page);

        return result;
    }
}
