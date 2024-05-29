package com.wa.erp;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Controller
public class MainController {

  @RequestMapping(value = {"/"}, name = "메인")
  public String mainAction(Map<String, Object> model) {
    return "main";
  }

}
