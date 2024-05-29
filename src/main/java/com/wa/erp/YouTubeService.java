package com.wa.erp;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import com.wa.erp.YouTubeCrawling;
import java.util.*;

@Slf4j
@Service
@RequiredArgsConstructor
public class YouTubeService {

  public HashMap YouTubeCrawling () {

    HashMap result2 = new HashMap();
    
    YouTubeCrawling crawler2 = new YouTubeCrawling();

//    String searchWord ="코스모";
    // 드라이버 생성
//    crawler2.preCondition(searchWord);
    crawler2.preCondition();
    
    // 탭클릭
    crawler2.clickTab();

    // 헤드라인 유튜브 영상 정보
    HashMap headLineInfo = crawler2.getHeadLineInfo();
    
    result2.put("reulst",headLineInfo);

    try {
      // 드라이버 종료
      crawler2.postCondition();
    } catch (Exception e) {
      
      result2.put("result", "ERROR");
      result2.put("errorMessage", e.getMessage());
    }

    return result2;
  }
}
