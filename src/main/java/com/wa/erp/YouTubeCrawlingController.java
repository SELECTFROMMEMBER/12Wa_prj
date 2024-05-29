package com.wa.erp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.wa.erp.NaverService;
import com.wa.erp.YouTubeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/YouTube")
public class YouTubeCrawlingController {
	
	  private final YouTubeService YouTubeService = new YouTubeService();

	  @RequestMapping("")
	  public HashMap YouTubeCrawling (){
	    return YouTubeService.YouTubeCrawling();
	  }

}
