package com.wa.erp;

import java.util.HashMap;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/naver")
public class NaverCrawlingController {
	
	  private final NaverService naverService = new NaverService();

	  @RequestMapping("")
	  public HashMap newsCrawling (){
	    return naverService.newsCrawling();
	  }

}
