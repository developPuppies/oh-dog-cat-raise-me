package com.ohdogcat.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ohdogcat.dto.product.ProductListDto;
import com.ohdogcat.dto.product.ProductPetTypeDto;
import com.ohdogcat.dto.product.ProductOptionListDto;
import com.ohdogcat.model.ProductOption;
import com.ohdogcat.service.ProductService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/product")
public class ProductController {

	@Autowired
	private ProductService productService;
	
	@GetMapping("/list")
	public void getProductList(@RequestParam(defaultValue = "1") Long petType,
					           @RequestParam(defaultValue = "create_date") String orderBy,
					           @RequestParam(defaultValue = "1") int page,
					           @RequestParam(defaultValue = "20") int size,
					           Model model) {
		List<ProductListDto> products = productService.getProducts(petType, orderBy, page, size);
		int totalProducts = productService.getTotalProductsCount(petType, null, null, null, null); 
		int totalPages = (int) Math.ceil((double) totalProducts / size);

		model.addAttribute("products", products);
		model.addAttribute("totalPages", totalPages);

}
	
	// best페이지
	@GetMapping("/collection/best")
	public void getBestProducts(@RequestParam(defaultValue = "1") Long petType,
	                            @RequestParam(defaultValue = "sold") String orderBy,
	                            @RequestParam(defaultValue = "1") int page,
	                            @RequestParam(defaultValue = "20") int size,
	                            Model model) {
	    List<ProductListDto> products = productService.getProducts(petType, orderBy, page, size);
	    int totalProducts = productService.getTotalProductsCount(petType, null, null, null, null); 
	    int totalPages = (int) Math.ceil((double) totalProducts / size);
	    
	    model.addAttribute("products", products);
	    model.addAttribute("totalPages", totalPages);

	}
	
	// new페이지
	@GetMapping("/collection/new")
	public void getNewProducts(@RequestParam(defaultValue = "1") Long petType,
		                       @RequestParam(defaultValue = "create_date") String orderBy,
		                       @RequestParam(defaultValue = "1") int page,
		                       @RequestParam(defaultValue = "20") int size,
		                       Model model) {
		 List<ProductListDto> products = productService.getProducts(petType, orderBy, page, size);
		 int totalProducts = productService.getTotalProductsCount(petType, null, null, null, null); 
		 int totalPages = (int) Math.ceil((double) totalProducts / size);
		    
		 model.addAttribute("products", products);
		 model.addAttribute("totalPages", totalPages);

	}
	
	@GetMapping("/details")
	public void details(@RequestParam(name = "productPk") long productPk, Model model) {
		log.debug("details prodcutPk = {}", productPk);
		ProductPetTypeDto product = productService.readProduct(productPk);
		log.debug("product ={}", product);
		model.addAttribute("p", product);
	}
	
	// 상품PK에 따른 옵션 리스트 정보 불러오기
	@GetMapping("/option/all/{productPk}")
	@ResponseBody
	public ResponseEntity<List<ProductOptionListDto>> getOptionlist(@PathVariable long productPk) {
		log.debug("getOptionList(prodcutPk={})", productPk);
		List<ProductOptionListDto> productOption = productService.readProductOption(productPk);
		
		return ResponseEntity.ok(productOption);
	}
	
	// 옵션Pk에 따른 옵션 정보 불러오기
	@GetMapping("/option/{optionPk}")
	@ResponseBody
	public ResponseEntity<ProductOption> getOption(@PathVariable long optionPk){
		log.debug("getOption(optionPk={})",optionPk);
		ProductOption option = productService.readOption(optionPk);
		return ResponseEntity.ok(option);
	}
	
	
}
