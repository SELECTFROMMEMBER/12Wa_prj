package com.wa.erp;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import com.wa.erp.NaverCrawling;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class NaverService {

  public HashMap newsCrawling () {

    HashMap result = new HashMap();
    
    NaverCrawling crawler = new NaverCrawling();

    // 드라이버 생성
    crawler.preCondition();
    
    // 탭클릭
    crawler.clickTab();

    // 헤드라인 뉴스 정보
    HashMap headLineInfo = crawler.getHeadLineInfo();
    
    result.put("reulst",headLineInfo);

    try {
      // 드라이버 종료
      crawler.postCondition();
    } catch (Exception e) {
      
      result.put("result", "ERROR");
      result.put("errorMessage", e.getMessage());
    }

    return result;
  }
}