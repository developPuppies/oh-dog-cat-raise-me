/**
 * cart/list.jsp에 포함되는 js
 */

document.addEventListener("DOMContentLoaded",() => {
	// 펫타입별 장바구니 영역 및 상품이 있는 경우 펫타입별 리스트로 들어갈 자리
    const dogCart = document.querySelector("div#dogCart");
	const dogItemList = document.querySelector("ul#dogItemList");
    const catCart = document.querySelector("div#catCart");
	const catItemList = document.querySelector("ul#catItemList");
    const emptyCart = document.querySelector("div#emptyCart");

	// 장바구니에 상품이 있는 경우에만 보여줄 영역
	const checkedDeleteArea = document.querySelector("div#checkedDeleteArea");
	const amountArea = document.querySelector("div#amountArea");
	const orderArea = document.querySelector("div#orderArea");

	// 체크박스 
	const allDogCheckBox = document.querySelector("input#allDogItemCheck");
	const allCatCheckBox = document.querySelector("input#allCatItemCheck");
	

	// 선택상품 삭제 버튼
	const btnCheckedDelete = document.querySelector("button#btnCheckedDelete");
	
	// 결제 금액 부분
	const amountValue = document.querySelector("span#amountValue");
	const paymentValue = document.querySelector("span#paymentValue");
	const totalProductCount = document.querySelector("span#totalProductCount");

	// 주문
	const btnSelectedOrders = document.querySelector("button#btnSelectedOrders");
	const btnAllOrders = document.querySelector("button#btnAllOrders");

	// 옵션 변경 
	const optionChangeModal = new bootstrap.Modal("div#optionChangeModal",{backdrop: true});
	const btnApplyOption = document.querySelector("a#btnApplyOption");
	let beforeOptionFk = 0;
	

	getAllCartList();

	allDogCheckBox.addEventListener("click", () => toggleAllItems(allDogCheckBox, dogItemList));
	allCatCheckBox.addEventListener("click", () => toggleAllItems(allCatCheckBox, catItemList));
	btnCheckedDelete.addEventListener("click", deleteCheckedItems);
	btnSelectedOrders.addEventListener("click", onSelectedOrders);
	btnAllOrders.addEventListener("click", onAllOrders);


	/* -------------------------------------------------- ★ 기능 영역 ★ -------------------------------------------------- */
	
	// 선택 주문
	function onSelectedOrders(){
		console.log("onSelectedOrders()");
		const checkboxes = document.querySelectorAll("input#itemChecked");
		const checkedItems = [];
		checkboxes.forEach( checkbox => {
			if (checkbox.checked && checkbox.value.trim() !== "") {
				checkedItems.push(checkbox.value);
			}
		});	
		if(checkedItems.length === 0){
			alert("선택된 상품이 없습니다!");
		}
		console.log(checkedItems);
		
		let uri = "../order/checkout?";
		checkedItems.forEach( optionfk => {
			uri += `optionfk=${optionfk}&`				
		})
		uri += "ordertype=c";

		location.href = uri;
	}

	// 전체 주문
	function onAllOrders(){
		console.log("onAllOrders()");
		const checkboxes = document.querySelectorAll("input#itemChecked");
		const checkedItems = [];
		checkboxes.forEach( checkbox => {
			// 품절 상품 제외
			if (checkbox.value.trim() !== "" && !checkbox.disabled) {
				checkedItems.push(checkbox.value);
			}
		});	
		if(checkedItems.length === 0){ 
			alert("장바구니 상품이 없습니다!");
		}
		console.log(checkedItems);

		let uri = "../order/checkout?";
		checkedItems.forEach( optionfk => {
			uri += `optionfk=${optionfk}&`				
		})
		uri += "ordertype=c";

		location.href = uri;
	}

	// 장바구니 상품 불러오기
	async function getAllCartList() {
		console.log("getAllCartList()");
		try {
			const uri = `list/all/items`;
			const response = await axios.get(uri);

			dogCart.classList.add("d-none");
			catCart.classList.add("d-none");
			checkedDeleteArea.classList.add("d-none");
			amountArea.classList.add("d-none");			
			orderArea.classList.add("d-none");
			dogItemList.innerHTML = "";
			catItemList.innerHTML = "";

			paintCartList(response.data);
		} catch (error) {
			console.error("장바구니 목록을 불러오는 중 오류가 발생했습니다:", error);
		}
    }

	// 상품의 펫타입별로 장바구니 구분  
    function paintCartList(cartList) {
		console.log("getAllCartList() => paintCartList()")
        console.log("카트 상품 갯수 = ",cartList.length);

        if (cartList.length === 0) {
            emptyCart.classList.remove("d-none");
			return;
        }

		checkedDeleteArea.classList.remove("d-none");
		amountArea.classList.remove("d-none");			
		orderArea.classList.remove("d-none");

		for(let cartItem of cartList){
			if(cartItem.pet_type === 1){
				makeCartListElements(cartItem, dogItemList);
				dogCart.classList.remove("d-none");				
			} else{
				makeCartListElements(cartItem, catItemList);
				catCart.classList.remove("d-none");
			}
		}	
		
		updatePaymentArea();
    }

	// 상품 목록 <li> 그리기
	function makeCartListElements(cartItem, parentList){
		console.log("paintCartList()=> makeCartListElements()", parentList);
		const itemList = document.createElement("li");
		const totalItemPrice = cartItem.price * cartItem.count;
		const detailsPage = `/ohdogcat/product/details?productPk=${cartItem.product_pk}`;
		
		itemList.classList.add("list-group-item", "mt-3", "pb-4", "text-center");
		itemList.innerHTML = `
			 	<div class="row fw-semibold">
					<!-- 1. 상품 영역  -->
					<div class="col-8">
						<div class="row">
							<div class="col-1 form-check fs-5 align-self-center" style="width: auto;">
								<input class="form-check-input" type="checkbox" value="${cartItem.option_fk}"
								data-price="${cartItem.price}" data-count="${cartItem.count}" id="itemChecked" checked></div>
							<!-- 상품 사진 -->
							<div class="col-2">
                        		<a href="${detailsPage}"><img src="${cartItem.img_url}" class="img-fluid rounded d-block" alt="product Img" style="width: 100%;"></a>
							</div>
							<!-- 상품 이름-->
							<div class="col-9 align-self-center fw-normal" style="text-align: left;">
								<div class="row">
									<div class="col">
										<a href="${detailsPage}"><div class="fw-semibold" style="font-size: 17px;">${cartItem.product_name}</div></a>
										<div>${cartItem.min_price.toLocaleString('ko-KR')}원</div>
										
									    <div class="fs-6 pt-1 d-none" id="soldout-text">
                                        	<span class="text-black-50" style="text-decoration-line: line-through;">
                                        		옵션 : [${cartItem.option_name}] ${cartItem.price.toLocaleString('ko-KR')}원
                                    		</span>
                                            <span class="fw-semibold" style="color: red;">[ sold out ]</span>
                                        </div>
										<div class="fs-6 pt-1 text-black-50" id="not-soldout-text">옵션 : [${cartItem.option_name}] ${cartItem.price.toLocaleString('ko-KR')}원</div>
										<!-- 옵션 변경 -->
										<button class="btn btn-warning mt-2 btn-sm text-white" data-productpk="${cartItem.product_pk}"
										id="btnChangeOption" type="button" style="border-radius: 8px; background-color: #ffc107 !important;">옵션변경</button>                                       
									</div>
								    <div class="col-1 align-self-center">      
        	                            <i class="btn bi bi-x-square" id="btnDelete" style="font-size: 24px; color: rgb(207, 207, 207);" ></i>
    	                            </div>
								</div>
							</div>
						</div>
					</div>
					<!-- 2. 수량 영역 -->
					<div class="col-2 align-self-center">
						<div class="input-group justify-content-center">
							<div class="input-group-prepend">
								<button class="btn btn-warning text-white fw-bold btn-sm" type="button" id="btnMinus" style="border-radius: 0; height: 30px;">-</button>
							</div>
							<input type="text" class="text-center" value="${cartItem.count}" id="count" readonly style="border: 0; width: 40px; font-size: 0.8em; height: 30px;">
							<div class="input-group-append">
								<button class="btn btn-warning text-white fw-bold btn-sm" type="button" id="btnPlus" style="border-radius: 0; height: 30px;">+</button>
							</div>
						</div>
					</div>

					<!-- 3. 주문 금액 영역 -->
					<div class="col-2 align-self-center">
						<div id = "totalItemPrice" style="font-size: 18px;">${totalItemPrice.toLocaleString('ko-KR')}원</div>
						<div class="fs-6 fw-normal text-black-50">무료배송</div>
					</div>
				</div>      
		`;
		parentList.appendChild(itemList);
		
		if(cartItem.stock === 0){
			console.log("재고 품절");
			itemList.querySelector("input#itemChecked").checked = false;
		    itemList.querySelector("button#btnMinus").disabled = true;
		    itemList.querySelector("button#btnPlus").disabled = true;
		    itemList.querySelector("input#itemChecked").disabled = true;
		    itemList.querySelector("div#soldout-text").classList.remove("d-none");
			itemList.querySelector("div#not-soldout-text").classList.add("d-none");
		}


		const btnDelete = itemList.querySelector("i#btnDelete");
		btnDelete.addEventListener("click", () => deleteCartItem(cartItem.option_fk, itemList)); 

		const btnMinus = itemList.querySelector("button#btnMinus");
		btnMinus.addEventListener("click",() => pushMinusBtn(itemList, cartItem));

   		const btnPlus = itemList.querySelector("button#btnPlus");
		btnPlus.addEventListener("click",() => pushPlusBtn(itemList, cartItem));

		const btnChangeOption = itemList.querySelector("button#btnChangeOption");
		btnChangeOption.addEventListener("click",() => changeOption(itemList,cartItem));    
		
		const inputChkBox = itemList.querySelector('input#itemChecked');
		inputChkBox.addEventListener("click", () => updatePaymentArea());

	}

	// 수량 - 버튼
	async function pushMinusBtn(itemList, item){
		console.log("makeCartListElements()=>pushMinusBtn()",item);
		let count = itemList.querySelector("input#count");
		const inputChkBox = itemList.querySelector('input#itemChecked');

		let currentCount = parseInt(count.value);

		if(currentCount == 1 || currentCount == 0) {
			alert("1개 이상부터 구매할 수 있습니다!")
			return;
		}
		currentCount += -1;
		count.setAttribute("value", currentCount);
		inputChkBox.setAttribute("data-count", currentCount);

		updateTotalItemPrice(itemList,-item.price);
		updatePaymentArea();

		const update = {count: currentCount, option_fk: item.option_fk};
		console.log(update);
		try{
			const uri = `list/update/${item.option_fk}`;
			const response = await axios.put(uri,update);
			const result = response.data;
			console.log("result",result);
		} catch(error){
			console.log("장바구니 업데이트 실패",error);
		}

	}

	// 수량 + 버튼
	async function pushPlusBtn(itemList, item){
		console.log("makeCartListElements()=>pushMinusBtn()",item);
		let count = itemList.querySelector("input#count");
		const inputChkBox = itemList.querySelector('input#itemChecked');

		let currentCount = parseInt(count.value);

		if(currentCount >= item.stock && item.stock <= 10) {
			alert(`현재 구매 가능한 수량은 ${item.stock}개 입니다! `)
			return;
		} else if(currentCount >= 10 ) {
			alert(`옵션별 최대 10개까지 구매할 수 있습니다!`)
			return;			
		} 
		currentCount += 1;
		count.setAttribute("value", currentCount);
		inputChkBox.setAttribute("data-count", currentCount);

		updateTotalItemPrice(itemList, item.price);
		updatePaymentArea();

		const update = {count: currentCount, option_fk: item.option_fk};
		console.log(update);
		try{
			const uri = `list/update/${item.option_fk}`;
			const response = await axios.put(uri,update);
			const result = response.data;
			console.log("result",result);
		} catch(error){
			console.log("장바구니 업데이트 실패",error);
		}
	}

	// 단일 상품의 상품금액(+,- 버튼 선택 시 업데이트)
	function updateTotalItemPrice(itemList, price) {
		console.log("updateTotalItemPrice()");
		let totalItemPrice = itemList.querySelector("div#totalItemPrice");
		let currentTotal = parseInt(totalItemPrice.innerText.replace(/[^\d.-]/g, '')) || 0;
		currentTotal += price;
		totalItemPrice.innerText = currentTotal.toLocaleString('ko-KR') + "원";
	}

	// 총 선택 된 상품의 금액(수량 증감 및 상품 체크 유무에 따라 변경) 
	function updatePaymentArea(){
		console.log("updatePaymentArea()");
		let currentProductCount = 0; // 총 상품 갯수
		let totalOptionCount = 0; // 총 옵션 갯수
		let currentAmountValue = 0; // 옵션 * 상품 가격
		const checkboxes = document.querySelectorAll("input#itemChecked");
		checkboxes.forEach( checkbox => {
			if (checkbox.checked && checkbox.value.trim() !== "") {
				const priceAttribute = checkbox.getAttribute("data-price");
				const countAttribute  = checkbox.getAttribute("data-count");
				currentProductCount += 1;
				totalOptionCount += parseInt(countAttribute);
				currentAmountValue += parseInt(priceAttribute) * parseInt(countAttribute);
			}
		});
		totalProductCount.innerText = currentProductCount;
		amountValue.innerText = currentAmountValue.toLocaleString('ko-KR');
		paymentValue.innerText = currentAmountValue.toLocaleString('ko-KR');
	}

	// 단일 상품 삭제
	async function deleteCartItem(option_fk){
		console.log("makeCartListElements()=>deleteCartItem()",option_fk);
		const uri = `list/delete/${option_fk}`;
		try{
			const response = await axios.delete(uri);
			if (response.data === 1) {
				getAllCartList();
				updateCartQuantity();
			}
		} catch(error){
			console.log(error);
		}
	}

	// 선택된 상품 삭제
	async function deleteCheckedItems(){
		console.log("deleteCheckedItems()");
		const checkboxes = document.querySelectorAll("input#itemChecked");
		const checkedItems = [];
		checkboxes.forEach( checkbox => {
			if (checkbox.checked && checkbox.value.trim() !== "") {
				checkedItems.push(checkbox.value);
			}
		});
		checkedItems.forEach( item => { 
			deleteCartItem(item);
		});
		updateCartQuantity();
	}

	// 펫타입별 전체 선택 
	function toggleAllItems(checkbox, itemList) {
		console.log("toggleAllItems()");
		const list = itemList.querySelectorAll("li");
		for (let li of list) {
			//품절 상품은 선택 x
			if(!li.querySelector("input#itemChecked").disabled)
			li.querySelector("input#itemChecked").checked = checkbox.checked;
		}
		updatePaymentArea()
	}

	const btnOption = document.querySelector("button#btnOption");
	// 옵션 변경 버튼 선택 
	function changeOption(itemList, cartItem){
		console.log("makeCartListElements()=>changeOption()",cartItem);
		beforeCount = itemList.querySelector("input#count").value;
		beforeOptionFk = cartItem.option_fk;
		
		btnOption.innerText = "상품 옵션을 선택하세요";
		btnOption.onclick =() =>{
			getOptionList(cartItem);
		}
		optionChangeModal.show();
	}
	
	// 해당 상품의 옵션 리스트 
	async function getOptionList(cartItem){
		console.log("changeOption()=>getOptionList()");
		const uri = `../product/option/all/${cartItem.product_pk}`;
		const response = await axios.get(uri);
		makeOptionListElements(response.data);
	}

	// 상품 옵션 <li> 그리기
	function makeOptionListElements(data) {
		console.log("getOptionList()=>makeOptionListElements()");
		const optionList = document.querySelector("ul#optionList");
		let htmlStr = "";

		for (let option of data) {
			htmlStr += `
			 	<li class = "optionItem">
			 		<div class="dropdown-item" data-id="${option.option_Pk}" style ="cursor: pointer">
			 			 ${option.option_Name} ${option.price} - 재고: ${option.stock}
		 			</div>
	 			</li>`
		}
		optionList.innerHTML = htmlStr;

		const optionItems = document.querySelectorAll("div.dropdown-item");
	

		for (let item of optionItems) {
			item.addEventListener("click", (event) => clickOption(event));
		}
	} 

	// 옵션 선택 시 
	async function clickOption(e) {
		console.log("makeOptionListElements()=>clickOption()");
        const optionPk = e.target.getAttribute("data-id");
        const uri = `../product/option/${optionPk}`;
        const response = await axios.get(uri);
        const option = response.data;

		if(option.stock <= 0){
			alert("현재 해당 옵션은 재고가 부족합니다!")
			return;
		}
		btnOption.innerText = `변경 옵션 : [${option.optionName}] ${option.price.toLocaleString('ko-KR')}원`;	

		//이벤트 리스너 누적 안 되게..!!
		//1대1 바인딩..같은 요소에 이벤트를 하나만 등록
		btnApplyOption.onclick =() =>{
			changeCartItem(option.optionPk);
		}
    }

	// 옵션 변경 후 적용 버튼 누를 시
	async function changeCartItem (afterOptionFk){
		console.log("clickOption()=>changeCartItem()");
		const cartUpdateData = {
			beforeOption_fk : beforeOptionFk,
			afterOption_fk : afterOptionFk
		}
		const uri = `list/update/changeoption`;
		const response = await axios.put(uri, cartUpdateData);
		console.log("적용 결과",typeof response.data, response.data);
		console.log("afterOptionFk",afterOptionFk);
		if(response.data == 0){
			alert("이미 장바구니에 있는 옵션입니다!");
		} else{
			alert("옵션이 변경되었습니다!");
		}
		getAllCartList();
		location.href = location.href;
	}






}); // end document.addEventListener