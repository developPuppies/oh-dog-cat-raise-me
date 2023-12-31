package com.ohdogcat.service;

import com.ohdogcat.dto.ReviewListItemDto;
import com.ohdogcat.dto.ReviewSatisfactionDto;
import com.ohdogcat.dto.member.review.ReviewDeleteDto;
import com.ohdogcat.dto.member.review.ReviewDetailDto;
import com.ohdogcat.dto.member.review.ReviewDetailFindDto;
import com.ohdogcat.dto.member.review.ReviewListDto;
import com.ohdogcat.dto.member.review.ReviewRegisterDto;
import com.ohdogcat.enums.PurchaseStatusEnum;
import com.ohdogcat.repository.ReviewDao;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@RequiredArgsConstructor
@Service
public class ReviewService {

    private final ReviewDao reviewDao;

    public Map<String, Object> getReviewDataAtProductPage(Map<String, Object> reviewDataMap) {
        Map<String, Object> result = new HashMap<>();

        ReviewSatisfactionDto satisfaction = reviewDao.getReviewSatisfaction(
            (Long) reviewDataMap.get("productPk"));
        result.put("satisfaction", satisfaction);

        List<ReviewListItemDto> reviewListItems = reviewDao.getReviewListDtoAtProduct(
            reviewDataMap);
        result.put("reviewList", reviewListItems);

        return result;
    }

    public String clickLike(Map<String, Object> reviewLikeDataMap) {
// db에 있나 체크
        Integer isDuplicated = reviewDao.checkDuplicateLike(reviewLikeDataMap);

        if (isDuplicated != 0) {
            Integer result = reviewDao.deleteLike(reviewLikeDataMap);

            if (result == 0) {
                return "delete_failed";
            }

            return "deleted";
        }

        Integer result = reviewDao.createLike(reviewLikeDataMap);
        if (result == 0) {
            return "create_failed";
        }
        return "created";
    }

    // 리뷰에 필요한 목록 불러오기
    public List<ReviewDetailDto> selectReviewDetailViews(ReviewDetailFindDto dto) {
        log.debug("selectReviewDetailViews(dto={})", dto);

        // 리뷰 작성할 때 중복된 값(같은 옵션에 또 작성)이 있으면 작성이 안되게끔
        List<ReviewDetailDto> list = reviewDao.selectReviewDetailViews(dto);
        List<ReviewListDto> checkList = reviewDao.selectReviewByMemberFk(dto.getMember_fk());
        log.debug("list={}, checkList={}, dto.getMember_fk()={}", list, checkList,
            dto.getMember_fk());

        if (list != null && !list.isEmpty()) {
            boolean allMatch = false;
            for (int i = 0; i < list.size(); i++) {
                if (i < checkList.size()
                    && list.get(i).getOption_name().equals(checkList.get(i).getOption_name())) {
                    allMatch = true;
                    break;
                }
            }

            if (allMatch
                || list.get(0).getStatus_pk()
                   != PurchaseStatusEnum.CONFIRMED_PURCHASE.getStatus_pk()) {
                list = null;
            }
        } else {
            list = null;
        }

        return list;
    }

    // 리뷰 작성
    public void insertReview(ReviewRegisterDto dto) {
        log.debug("insertReview(dto={})", dto);

        reviewDao.insertReview(dto.toEntity());
    }

    // 리뷰 삭제
    public int deleteWhereReviewAndMemberFk(ReviewDeleteDto dto) {
        int result = reviewDao.deleteWhereReviewAndMemberFk(dto.toEntity());

        return result;
    }

    // 내가 쓴 리뷰 보기
    public List<ReviewListDto> selectReviewByMemberFk(long member_fk) {
        List<ReviewListDto> list = reviewDao.selectReviewByMemberFk(member_fk);

        return list;
    }
}
