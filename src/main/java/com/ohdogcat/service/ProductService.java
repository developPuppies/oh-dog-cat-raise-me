package com.ohdogcat.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.ohdogcat.dto.product.ProductOptionListDto;
import com.ohdogcat.dto.product.ProductPetTypeDto;
import com.ohdogcat.model.ProductOption;
import com.ohdogcat.repository.ProductDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductService {
	private final ProductDao productDao;
	
	public List<ProductPetTypeDto> readDogOrderByNew(){
		log.debug("readDogOrderByNew()");
		List<ProductPetTypeDto> list = productDao.selectDogTypeOrderByCreateDesc();
		return list;
	}
	
	public List<ProductPetTypeDto> readDogOrderByBest(){
		log.debug("readDogOrderByBest()");
		List<ProductPetTypeDto> list = productDao.selectDogTypeOrderBySoldDesc();
		return list;
	}
	
	public List<ProductPetTypeDto> readCatOrderByNew(){
		log.debug("readCatOrderByNew()");
		List<ProductPetTypeDto> list = productDao.selectCatTypeOrderByCreateDesc();
		return list;
	}
	
	public List<ProductPetTypeDto> readCatOrderByBest(){
		log.debug("readCatOrderByBest()");
		List<ProductPetTypeDto> list = productDao.selectCatTypeOrderBySoldDesc();
		return list;
	}

	public ProductPetTypeDto readProduct(long productPk) {
		log.debug("readProduct()");
		ProductPetTypeDto product = productDao.selectByProductPk(productPk);
		return product;
	}

	public List<ProductOptionListDto> readProductOption(long productPk) {
		log.debug("readProductOption()");
		List<ProductOptionListDto> list = productDao.selectOptionByProduckPk(productPk);
		return list;
	}

	public ProductOption readOption(long optionPk) {
		log.debug("readOption()");
		ProductOption option = productDao.selectOptionByOptionPk(optionPk);
		return option;
	}
	
	
}
