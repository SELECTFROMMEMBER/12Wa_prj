<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common.jsp"%>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%> 
<%@ page import="com.wa.erp.BoardDTO" %>
<!DOCTYPE html>
<html>

<head>
<script>
$(document).ready(function() {
    // 페이지 로드 시, 두 번째와 세 번째 셀렉트 박스를 비활성화
 
    $('#multisort2').prop('disabled', true);
    $('#multisort3').prop('disabled', true);
    
    // 첫 번째 셀렉트 박스의 값이 변경될 때
    $('#multisort1').on('change', function() {
        var value = $(this).val();
        if (value) {
            // 첫 번째 셀렉트 박스가 선택되면 두 번째 셀렉트 박스를 활성화
            $('#multisort2').prop('disabled', false);
            // 두 번째 셀렉트 박스의 옵션 변경
            $('#multisort2 option[value!=""]').remove();
            if (value !== 'sal_avg desc') {
                $('#multisort2').append('<option value=",sal_avg desc">평균 연봉</option>');
            }
            if (value !== 'sales desc') {
                $('#multisort2').append('<option value=",sales desc">매출</option>');
            }
            if (value !== '7 desc') {
                $('#multisort2').append('<option value=",7 desc">별점</option>');
            }
        } else {
            // 선택되지 않으면 나머지 셀렉트 박스를 비활성화하고 초기화
            $('#multisort2').prop('disabled', true).val('');
            $('#multisort3').prop('disabled', true).val('');
        }
        // 호출할 search 함수
       searchWithMultiSort();
    });

    // 두 번째 셀렉트 박스의 값이 변경될 때
    $('#multisort2').on('change', function() {
        var value = $(this).val();
        if (value) {
            // 두 번째 셀렉트 박스가 선택되면 세 번째 셀렉트 박스를 활성화
            $('#multisort3').prop('disabled', false);
            // 세 번째 셀렉트 박스의 옵션 변경
            $('#multisort3 option[value!=""]').remove();
            if (value !== ',sal_avg desc' && $('#multisort1').val()!=='sal_avg desc') {
                $('#multisort3').append('<option value=",sal_avg desc">평균 연봉</option>');
            }
            if (value !== ',sales desc' && $('#multisort1').val()!=='sales desc') {
                $('#multisort3').append('<option value=",sales desc">매출</option>');
            }
            if (value !== ',7 desc' && $('#multisort1').val()!=='7 desc') {
                $('#multisort3').append('<option value=",7 desc">별점</option>');
            }
        } else {
            // 선택되지 않으면 세 번째 셀렉트 박스를 비활성화하고 초기화
            $('#multisort3').prop('disabled', true).val('');
        }
        // 호출할 search 함수
        searchWithMultiSort();
    });

    // 세 번째 셀렉트 박스의 값이 변경될 때
    $('#multisort3').on('change', function() {
        // 호출할 search 함수
searchWithMultiSort()  ;
        });
});
</script>

<style>
.fas.fa-heart {
    color: red;
}
.star-container {
      font-size: 18px;
      display: flex;
      align-items: center;
      gap: 10px;
    }

    .star {
      background: linear-gradient(to right, #EAB838, #EAB838 50%, #E0E2E7 50%);
      color: transparent;
      -webkit-background-clip: text;
    }

    .star-container .star-grade {
      font-weight: 700;
    }

	        .container {
            text-align: center;
        }
        .welfare-options {
            display: inline-block;
            text-align: left;
            margin: 0 auto;
            columns: 4; /* 두 개의 열로 나누어 정렬 */
            column-gap: 20px; /* 열 간격 */
        }
        .welfare-options label {
            display: block;
            margin: 5px 0;
        }

  #firstSelect {
    text-align: center; /* 텍스트를 수평 가운데 정렬합니다. */
  }
  #firstSelect option {
    text-align: center; /* 옵션 텍스트를 수평 가운데 정렬합니다. */
  }
   #secondSelect {
    text-align: center; /* 텍스트를 수평 가운데 정렬합니다. */
  }
  #secondSelect option {
    text-align: center; /* 옵션 텍스트를 수평 가운데 정렬합니다. */
  }
   #thirdSelect {
    text-align: center; /* 텍스트를 수평 가운데 정렬합니다. */
  }
  #thirdSelect option {
    text-align: center; /* 옵션 텍스트를 수평 가운데 정렬합니다. */
  }
</style>
<script>

function search(){
	//---------------------------------------------
	// 변수 boardSearchFormObj 선언하고 
	// name='boardSearchForm' 를 가진 form 태그 관리 JQuery 객체를 생성하고 저장하기
	//---------------------------------------------
	var boardSearchFormObj = $("[name='boardSearchForm']");
	var searchWithIndustry = boardSearchFormObj.find("select").val();
	var sidoObj            = boardSearchFormObj.find(".sido").val();
	var gugunObj           = boardSearchFormObj.find(".gugun").val();
	var welfareObj = boardSearchFormObj.find('[name="welfare"]:checked').map(function() { return this.value; }).get();
	// 검색 함수 호출
	var keywordObj        = boardSearchFormObj.find(".keyword");
	var keyword             = keywordObj.val();
		if( typeof(keyword)!='string' ){ keyword = ""; }
	keyword = $.trim(keyword);
	keywordObj.val(keyword);
	boardSearchFormObj.find(".rowCntPerPage").val($("select").filter(".rowCntPerPage").val())
	   if($('#multisort1').val()==''){
		    $('#multisort2').prop('disabled', true);
		    $('#multisort3').prop('disabled', true);
		    };
// 	   if($('#multisort1').val()==''){
// 		    $('#multisort2').prop('disabled', true);
// 		    $('#multisort3').prop('disabled', true);
// 		    };
	
	//-----------------------------------------------------
	// JQuery 객체의 [ajax 메소드]를 호출하여
	// WAS 에 "/boardList.do" 주소로 접속하고 
	// boardList.jsp 페이지의 실행 결과인 HTML 코드를 문자로 받아서
	// <div class='boardListDiv'> 태그 내부의 게시판 관련 검색 결과 목록 부분을
	// 현화면의 <div class='boardListDiv'> 태그 내부에 덮어쓰기
	//-----------------------------------------------------
	$.ajax(
		{
			//-------------------------------
			// WAS 로 접속할 주소 설정
			//-------------------------------
			url      : "/companyList.do"
			//-------------------------------
			// WAS 로 접속하는 방법 설정. get 또는 post
			//-------------------------------
			,type    : "post"
			//--------------------------------------
			// WAS 에 보낼 파명과 파값을 설정하기. "파명=파값&파명=파값~"
			//--------------------------------------
			,data    : boardSearchFormObj.serialize( )
			//----------------------------------------------------------
			// WAS 의 응답을 성공적으로 받았을 경우 실행할 익명함수 설정.
			// 이때 익명함수의 매개변수로 WAS 의 응답물이 들어 온다.
			// "/boardList.do" 주소의 응답물은  boardList.jsp 페이지의
			// 실행결과인 HTML 문서 문자열이이다.
			//----------------------------------------------------------
			,success : function(responseHtml){


            //-----------------------------------
            // 매개변수로 들어오는 HTML 문자열을 관리하는 
            // JQuery 객체 생성하여 변수 obj 에 저장하기
            //-----------------------------------
            var obj = $(responseHtml);
            
            //-----------------------------------
            // 매개변수로 받은 HTML 문자열 중에 
            // <div class='boardListDiv'> 태그 안의 html 문자열을
            // 현 화면의 <div class='boardListDiv'> 태그 안에  덮어쓰기
            //-----------------------------------boardListDiv pagingNos
            $(".boardListDiv").html( 
                  obj.filter(".boardListDiv").html() 
            );
            $(".pagingNos").html( 
                  obj.filter(".pagingNos").html() 
            );
         

            
            
//             $("body").append(
//                "<textarea class=xxx cols=100 rows=100>"
//                + obj.filter(".boardListDiv").html()
//                +"</textarea>"
            //)
            
         }
         ,error   : function(){
            alert("검색 실패! 관리자에게 문의 바람니다.");
         }
      }
   );
}
///////////////////////search()종료부분
function searchReset(){

   var boardSearchFormObj = $("[name='boardSearchForm']");
   boardSearchFormObj.find(".keyword").val("");
    $("[name='boardSearchForm']").find("[name='sort']").val("");
    $("[name='boardSearchForm']").find("[name='selectedIndustry']").val("");
    $("[name='boardSearchForm']").find("[name='sido']").val("시/도 선택");
    $("[name='boardSearchForm']").find("[name='gugun']").val("구/군 선택");
    document.getElementById('1').checked = false;
    document.getElementById('2').checked = false;
    document.getElementById('3').checked = false;
    document.getElementById('4').checked = false;
    document.getElementById('5').checked = false;
    document.getElementById('6').checked = false;
    document.getElementById('7').checked = false;
    document.getElementById('8').checked = false;
    document.getElementById('9').checked = false;
    document.getElementById('10').checked = false;
    document.getElementById('11').checked = false;
    document.getElementById('12').checked = false;
    document.getElementById('13').checked = false;
    document.getElementById('14').checked = false;
    document.getElementById('15').checked = false;
    document.getElementById('16').checked = false;
    $('#multisort1').val('');
	$('#multisort2').val('');
	$('#multisort3').val('');
    $(".searchBtn").click();
}

$("#1").checked = false;
$("#2").checked = false;
$("#3").checked = false;
$("#4").checked = false;
$("#5").checked = false;
$("#6").checked = false;
$("#7").checked = false;
$("#8").checked = false;
$("#9").checked = false;
$("#10").checked = false;
$("#11").checked = false;
$("#12").checked = false;
$("#13").checked = false;
$("#14").checked = false;
$("#15").checked = false;
$("#16").checked = false;





function searchWithIndustry(selectedIndustry){
    $("[name='boardSearchForm']").find("[name='selectedIndustry']").val(selectedIndustry);
   $(".searchBtn").click();
}


function searchWithSort(sort){

	$('#multisort1').val('');
	$('#multisort2').val('');
	$('#multisort3').val('');
	
	$("[name='boardSearchForm']").find("[name='sort']").val(sort);
    $(".searchBtn").click();

}

function gocompanyListDetailForm(c_no){
      $("[name='companyListDetailForm']").find("[name='c_no']").val(c_no);
   
       document.companyListDetailForm.submit();
   
}


function pageNoClick(clickPageNo){
//	alert(clickPageNo);
//---------------------------------------------
// name='selectPageNo' 를 가진 태그의 value 값에 
// 매개변수로 들어오는 [클릭한 페이지 번호]를 저장하기
// 즉 <input type="hidden" name="selectPageNo" value="1"> 태그에
// value 값에 [클릭한 페이지 번호]를 저장하기
//---------------------------------------------
$("[name='boardSearchForm']").find(".selectPageNo").val(clickPageNo);
search();
}

function searchWithMultiSort(){
	$("[name='boardSearchForm']").find("[name='sort']").val('');
	search();

}



</script>

</head>
<body>

      <%@ include file="header.jsp"%>


			<h1 style="text-align: center;">기업 정보</h1>


         <form name="boardSearchForm" onsubmit="return false">
            <div style="text-align: center; margin-bottom: 20px;">
                <select name="sido" id="sido" class="sido"></select>
                    <select name="gugun" id="gugun" class="gugun"></select>  
               <input type="text" name="keyword" class="keyword"> 
               <input type="button" value="검색" class="searchBtn" onclick="search()"></input>
                <input type="button" value="초기화" class="resetBtn" onclick="searchReset()">
                   <select name="rowCntPerPage" class="rowCntPerPage" onChange="search()" >
		<option value="10">10</option>
		<option value="20">20</option>
		<option value="30">30</option>
    </select>행보기 &nbsp;&nbsp;&nbsp;

        

				<br>
            <p align="center">
               업종<select name="selectedIndustry" class="selectedIndustry"
                  onChange="search()">
                  <option value="">업종을 선택해주세요.</option>
                  <option value="화장품 및 뷰티 제품 제조업">화장품 및 뷰티 제품 제조업
                  <option value="식품 및 음료 소매업">식품 및 음료 소매업
                  <option value="건설/건축 서비스">건설/건축 서비스
                  <option value="의료/보건 서비스">의료/보건 서비스
                  <option value="여행/관광 업종">여행/관광 업종
                  <option value="환경 보호/재활용 산업">환경 보호/재활용 산업
                  <option value="생활용품/가전제품 도매업">생활용품/가전제품 도매업
                  <option value="금융 및 보험 서비스">금융 및 보험 서비스
                  <option value="자동차 부품 제조업">자동차 부품 제조업
                  <option value="출판/인쇄 업종">출판/인쇄 업종
                  <option value="교육 기술 서비스">교육 기술 서비스
                  <option value="농업 및 농산물 가공 산업">농업 및 농산물 가공 산업
                  <option value="전자상거래/온라인 판매">전자상거래/온라인 판매
                  <option value="음악/예술 엔터테인먼트 산업">음악/예술 엔터테인먼트 산업
                  <option value="생명 공학/의료 기기 산업">생명 공학/의료 기기 산업
                  <option value="통신/네트워크 서비스">통신/네트워크 서비스
                  <option value="스포츠/운동 기술 산업">스포츠/운동 기술 산업
                  <option value="에너지/청정 기술 산업">에너지/청정 기술 산업
                  <option value="인테리어 디자인/가구 제조업">인테리어 디자인/가구 제조업
                  <option value="컴퓨터/소프트웨어 서비스">컴퓨터/소프트웨어 서비스
                  <option value="식물/원예 관련 서비스">식물/원예 관련 서비스
                  <option value="코스메틱/미용 서비스">코스메틱/미용 서비스
                  <option value="공예품/수공예품 제조업">공예품/수공예품 제조업
                  <option value="동물 의료 서비스">동물 의료 서비스
                  <option value="부동산 개발/투자">부동산 개발/투자
                  <option value="국제 무역/물류 서비스">국제 무역/물류 서비스
                  <option value="자원 관리/환경 컨설팅">자원 관리/환경 컨설팅
                  <option value="자료/정보 서비스">자료/정보 서비스
                  <option value="패션/의류 디자인 업종">패션/의류 디자인 업종
               </select>
            </p>
            <br>
            <div class="container">
		        <b>사내 복지</b><br>
		        <div class="welfare-options">
		            <label><input type="checkbox" name="welfare" value="4대보험가입" id="1"> 4대보험가입</label>
		            <label><input type="checkbox" name="welfare" value="연금가입" id="2"> 연금가입</label>
		            <label><input type="checkbox" name="welfare" value="보너스 및 인센티브" id="3"> 보너스 및 인센티브</label>
		            <label><input type="checkbox" name="welfare" value="수당제도" id="4"> 수당제도</label>
		            <label><input type="checkbox" name="welfare" value="사내동호회 운영" id="5"> 사내동호회 운영</label>
		            <label><input type="checkbox" name="welfare" value="경조사 지원" id="6"> 경조사 지원</label>
		            <label><input type="checkbox" name="welfare" value="출산/육아 지원제도" id="7"> 출산/육아 지원제도</label>
		            <label><input type="checkbox" name="welfare" value="사무용품 지원" id="8"> 사무용품 지원</label>
		            <label><input type="checkbox" name="welfare" value="자유복장" id="9"> 자유복장</label>
		            <label><input type="checkbox" name="welfare" value="식대제공" id="10"> 식대제공</label>
		            <label><input type="checkbox" name="welfare" value="기숙사 및 사택 제공" id="11"> 기숙사 및 사택 제공</label>
		            <label><input type="checkbox" name="welfare" value="차량유류비 지급" id="12"> 차량유류비 지급</label>
		            <label><input type="checkbox" name="welfare" value="통근버스 운행" id="13"> 통근버스 운행</label>
		            <label><input type="checkbox" name="welfare" value="교통비 지급" id="14"> 교통비 지급</label>
		            <label><input type="checkbox" name="welfare" value="유연근무제" id="15"> 유연근무제</label>
		            <label><input type="checkbox" name="welfare" value="각종 행사" id="16"> 각종 행사</label>
		        </div>
		    </div>
             <div>
             <br>
             
		<center>다중 정렬(내림차순)</center> 	
        <select id="multisort1"  name="multisort1"  >
                  <option value=''> 정렬 조건  </option>
                  <option value="sal_avg desc" >평균 연봉
                  <option value="sales desc"  >     매출
                  <option value="7 desc"> 별점
        </select>
 
        <!-- 두 번째 셀렉트 박스 -->
        <select id="multisort2" name="multisort2" >
				 <option value=''> 정렬 조건</option>		
                  <option value=",sal_avg desc">평균 연봉
                  <option value=",sales desc">     매출
                  <option value=",7 desc"> 별점        </select>
 
        <!-- 세 번째 셀렉트 박스 -->
        <select id="multisort3" name="multisort3" >
                  <option value=''> 정렬 조건 </option>
                  <option value=",sal_avg desc">평균 연봉
                  <option value=",sales desc">     매출
                  <option value=",7 desc"> 별점        </select>
    </div>
            <input type="hidden" name="selectPageNo" class="selectPageNo" value="1">
	        <input type="hidden" name="rowCntPerPage" class="rowCntPerPage">
            <input type="hidden" name="sort" class="sort" value="">
<!--             <input type="hidden" name="multisort1" class="multisort1" value=""> -->
<!--             <input type="hidden" name="multisort2" class="multisort2" value=""> -->
<!--             <input type="hidden" name="multisort3" class="multisort3" value=""> -->
            
         
            	    </div>
         	</form>
         	
         <br>
                  <div class="boardListDiv" id="container">
         
         <c:if
            test="${param.sort!='sal_avg asc' and param.sort!='sal_avg desc'}">
            <p style="cursor: pointer" onClick="searchWithSort('sal_avg desc')">연봉</p>
         </c:if>

         <c:if test="${param.sort=='sal_avg desc'}">
            <p style="cursor: pointer" onClick="searchWithSort('sal_avg asc')">연봉▼</p>
         </c:if>

         <c:if test="${param.sort=='sal_avg asc'}">
            <p style="cursor: pointer" onClick="searchWithSort('')">연봉▲</p>
         </c:if>

         <c:if test="${param.sort!='sales asc' and param.sort!='sales desc'}">
            <p style="cursor: pointer" onClick="searchWithSort('sales desc')">매출</p>
         </c:if>

         <c:if test="${param.sort=='sales desc'}">
            <p style="cursor: pointer" onClick="searchWithSort('sales asc')">매출▼</p>
         </c:if>

         <c:if test="${param.sort=='sales asc'}">
            <p style="cursor: pointer" onClick="searchWithSort('')">매출▲</p>
         </c:if>


         <br>

				
					<table
						style="border: 1px solid black; margin-left: auto; margin-right: auto;">



				<tr>
					<th>기업 정보</th>
						<c:if test="${param.sort!='7 asc' and param.sort!='7 desc'}">
            				<th style="cursor: pointer font-weight: bold;"onClick="searchWithSort('7 desc')">별점</th>
         				</c:if>
         				<c:if test="${param.sort=='7 desc'}">
            				<th style="cursor: pointer"onClick="searchWithSort('7 asc')">별점▼</th>
         				</c:if>
         				<c:if test="${param.sort=='7 asc'}">
            				<th style="cursor: pointer" onClick="searchWithSort('')">별점▲</th>
         				</c:if> 
						 <c:if test="${param.sort!='ci.rec_count asc' and param.sort!='ci.rec_count desc'}">
            				<th style="cursor: pointer"onClick="searchWithSort('ci.rec_count desc')">관심수</th>
         				</c:if>
         				<c:if test="${param.sort=='ci.rec_count desc'}">
            				<th style="cursor: pointer"onClick="searchWithSort('ci.rec_count asc')">관심수▼</th>
         				</c:if>
         				<c:if test="${param.sort=='ci.rec_count asc'}">
            				<th style="cursor: pointer" onClick="searchWithSort('')">관심수▲</th>
         				</c:if> 
				</tr>
                  <c:forEach var="board" items="${requestScope.companyList }"
                     varStatus="status">
                     					           
                     
                     <tr style="cursor: pointer"
                        onClick="gocompanyListDetailForm(${board.c_no});">
                        <td>
                           <div style="display: flex; align-items: center;">
                              <img width="80" src="images/photo-1.jpg" style="margin-right: 10px;">
                              <input type="hidden" value="	${requestScope.boardMap.begin_serialNo_desc - status.index}">
                        	  &nbsp;&nbsp;&nbsp;&lt기업명&gt	&nbsp;${board.name}<br>
                              &nbsp;&nbsp;&nbsp; &lt업종&gt &nbsp;&nbsp;&nbsp;${board.indus}<br>
                              &nbsp;&nbsp;&nbsp; &lt매출&gt &nbsp;&nbsp;&nbsp;${board.sales}<br>
                              &nbsp;&nbsp;&nbsp; &lt연봉&gt &nbsp;&nbsp;&nbsp;${board.sal_avg}<br>
                              &nbsp;&nbsp;&nbsp; &lt주소&gt &nbsp;&nbsp;&nbsp;${board.addr}<br>
                           </div>
                          </td>
                          <td align="center">
	                          <div class="star-container">
								<p class="star">★★★★★</p><br>
								<span class="star-grade" ><b>${board.star_avg}</b></span>
							 </div>
                          </td>
                          <td>
                              <c:choose>
								<c:when test="${likeNoList.contains(board.c_no)}">
									<i class="fas fa-heart"></i>
								</c:when>
								<c:otherwise>
									<i class="far fa-heart"></i>
								</c:otherwise>
							</c:choose>
							${board.rec_count}
					</td>
                     </tr>
                     						
                  </c:forEach>


               </table>
               <c:if test="${empty requestScope.companyList}">
                  <center>
                     <b> 조회할 데이터가 없습니다. </b>
                  </center>
               </c:if>
                              </div>
  <span class="pagingNos">
             		<center>
             
               		<span style="cursor:pointer"
				onClick="pageNoClick(1)">[처음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}-1)">[이전]</span>&nbsp;&nbsp;
		
		<!--------------------------------------------->
		<!--  [반복문 C코어 태그]를 사용하여 페이지 번호 출력하기 -->
		<!--------------------------------------------->
		<c:forEach var="pageNo"  begin = "${requestScope.boardMap.begin_pageNo}"    
								 end   = "${requestScope.boardMap.end_pageNo}">
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 같으면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo==pageNo}">
				${pageNo}
			</c:if>
			<!--------------------------------------------->
			<!--  만약에 [선택한 페이지 번호]와 [화면에 출력할 페이지 번호]가 다르면  -->
			<!--------------------------------------------->
			<c:if test="${requestScope.boardMap.selectPageNo!=pageNo}">
				<span style="cursor:pointer" onClick="pageNoClick(${pageNo})">[${pageNo}]</span>
			</c:if>
		</c:forEach>&nbsp;&nbsp;
		<!--------------------------------------------->
		<!-- [다음] [마지막] 출력하기 -->
		<!--------------------------------------------->
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.selectPageNo}+1)">[다음]</span>
		<span style="cursor:pointer" 
				onClick="pageNoClick(${requestScope.boardMap.last_pageNo})">[마지막]</span>
		&nbsp;&nbsp;&nbsp;		
		<!--------------------------------------------->
		[${requestScope.companyListCnt}/${requestScope.companyListAllCnt}]개 	
		
		<!--------------------------------------------->
		&nbsp;&nbsp;
               </center>
       
         
         <form name="companyListDetailForm" action="/companyListDetail.do"  method="post">
            <!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
            <input type="hidden" name="c_no" value="${board.c_no}">
         </form>
         	</span>

</body>
<%@ include file="footer.jsp"%>
</html>