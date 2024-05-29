package com.wa.erp;

import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.PageFactory;

import java.util.List;

public class YouTubePage {

  private WebDriver driver;

  public YouTubePage(WebDriver webDriver) {
    this.driver = webDriver;
    PageFactory.initElements(driver, this);
  }

  /*
   * 유튜브 영상 탭
  */
  
  @FindBy(xpath = "/html/body/ytd-app/div[1]/ytd-page-manager/ytd-search/div[1]")
  private List<WebElement> tabs;
  public List<WebElement> getTabs() {
    return tabs;
  }
  
  /*
   * 헤드라인 유튜브 List
   */
  
  @FindBy(css = "#contents > ytd-video-renderer")
  private List<WebElement> headLineList;
  public List<WebElement> getHeadLineList() {
    return headLineList;
  }
}
