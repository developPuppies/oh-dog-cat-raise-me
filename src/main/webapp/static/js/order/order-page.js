document.getElementById("daumPostOpenBtn").addEventListener("click",
    execDaumPostcode);
document.getElementById("daumPostOpenBtnInDiv").addEventListener("click",
    execDaumPostcode);

const addAddress = document.getElementById("add-address");
addAddress.classList.add("d-none");

function execDaumPostcode() {

  addAddress.classList.remove("d-none");

  new daum.Postcode({
    oncomplete: function (data) {
      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

      // 각 주소의 노출 규칙에 따라 주소를 조합한다.
      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
      addAddress.classList.remove("d-none");
      let addr = ''; // 주소 변수
      let extraAddr = ''; // 참고항목 변수

      //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
      if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
        addr = data.roadAddress;
      } else { // 사용자가 지번 주소를 선택했을 경우(J)
        addr = data.jibunAddress;
      }

      console.log(addr);

      // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
      if (data.userSelectedType === 'R') {
        // 법정동명이 있을 경우 추가한다. (법정리는 제외)
        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
          extraAddr += data.bname;
        }
        // 건물명이 있고, 공동주택일 경우 추가한다.
        if (data.buildingName !== '' && data.apartment === 'Y') {
          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName
              : data.buildingName);
        }
        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
        if (extraAddr !== '') {
          extraAddr = ' (' + extraAddr + ')';
        }
        // 조합된 참고항목을 해당 필드에 넣는다.
        console.log(extraAddr);
      }

      // 우편번호와 주소 정보를 해당 필드에 넣는다.
      document.getElementById('input-postcode').value = data.zonecode;
      document.getElementById("input-address").value = addr;
      document.getElementById("input-detail-addr").value = "";
      document.getElementById("input-recipient").value = "";

      document.getElementById("input-detail-addr").focus();
    }
  }).open();

}

document.getElementById("exec-add-addr").addEventListener("click",
    addAddressToSelectComponent);

function addAddressToSelectComponent(e) {

  const detail = document.getElementById("input-detail-addr").value;
  const recipient = document.getElementById("input-recipient").value;

  if (detail.length===0 || recipient.length === 0) {
    alert("상세주소와 받는 사람은 필수 정보입니다.");
    return;
  }

  let fullAddress = document.getElementById("input-address").value;
  fullAddress += (" " +detail);
  fullAddress += (" | " + recipient);

  // 컨트롤러에 요청 보내서 생성 후 fk 값 가져오기
  let address_fk = 1;

  const optionDiv = document.createElement("option");

  optionDiv.value = address_fk;
  optionDiv.innerHTML = fullAddress;

  // optionDiv.classList.add("")

  const addrSelected = document.getElementById("addr-selected");

  addrSelected.append(optionDiv);

  addAddress.classList.add("d-none");
}
