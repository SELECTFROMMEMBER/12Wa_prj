<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="/WEB-INF/views/common.jsp" %>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
  <script>
function gonoticeDetailForm(n_no){
    $("[name='noticeDetailForm']").find("[name='n_no']").val(n_no);

     document.noticeDetailForm.submit();
 
}
function gocompanyListDetailForm(c_no){
    $("[name='companyListDetailForm']").find("[name='c_no']").val(c_no);
 
     document.companyListDetailForm.submit();
 
}
</script>
<script type="text/javascript">
  google.charts.load('current', {
    'packages':['geochart'],
  });

  google.charts.setOnLoadCallback(drawRecordsStatisticsRegionRatioChart);

  function drawRecordsStatisticsRegionRatioChart() {
	  var data = google.visualization.arrayToDataTable([
	        ['Region', 'Popularity'],
	        <c:choose>
	            <c:when test="${sessionScope.member == 'company'}">
	                <c:forEach var="regionRatio" items="${requestScope.getPer_RegionCnt}" varStatus="status">
	                    ['서울', ${regionRatio.count_seoul}],
	                    ['경기도', ${regionRatio.count_gyeonggi}],
	                    ['KR-28', ${regionRatio.count_incheon}],
	                    ['강원도', ${regionRatio.count_gangwon}],
	                    ['KR-26', ${regionRatio.count_busan}]
	                    <c:if test="${!status.last}">,</c:if>
	                </c:forEach>
	            </c:when>
	            <c:otherwise>
	                <c:forEach var="regionRatio" items="${requestScope.RegionCount}" varStatus="status">
	                    ['서울', ${regionRatio.count_seoul}],
	                    ['경기도', ${regionRatio.count_gyeonggi}],
	                    ['KR-28', ${regionRatio.count_incheon}],
	                    ['강원도', ${regionRatio.count_gangwon}],
	                    ['KR-26', ${regionRatio.count_busan}]
	                    <c:if test="${!status.last}">,</c:if>
	                </c:forEach>
	            </c:otherwise>
	        </c:choose>
	    ]);

      var options = {
              region: 'KR',
              displayMode: 'regions',
              resolution: 'provinces',
              colorAxis: { minValue: 0 },
              title: '지역별 이용자 수'
          };

          var chart = new google.visualization.GeoChart(document.getElementById('recordsStatisticsRegionRatio'));

          chart.draw(data, options);

  }
</script>
</head>


<style>

	.promote {
    overflow: hidden;
    position: relative;
    width: 100%;
    height: 350px;
}

	.promote .bx-wrapper {
    height: 100%;
}

.promote_a {
	padding: 75px 0 0 150px;
	position: absolute;
	width: 100%;
	height: 100%;
	background-size: cover;
	background-position: right bottom;
}

.promote_a {
	background: url('/static/images/promote_a.png') no-repeat right bottom;
}

.promote_b {
	background: url('/static/images/promote_b.png') no-repeat right bottom;
	padding: 75px 0 0 750px;
	position: absolute;
	width: 100%;
	height: 100%;
	background-size: cover;
	background-position: right bottom;
}

.promote_a_title, .promote_b_title {
	font-size: 40px;
	font-weight: 200;
	color: #111;
	text-align: justify;
	line-height: 48px;
}

.promote_a_title b, .promote_b_title b {
	font-weight: 700 !important;
}

.promote_a_sub, .promote_b_sub {
	margin-top: 5px;
	font-size: 20px;
	font-weight: 200;
	color: #111;
	letter-spacing: -1px;
	line-height: 28px;
}

	.promote_a_btn {
    display: inline-block;
    margin-top: 13px;
    padding: 11px 20px;
    color: #111;
    border: 1px solid #111;
    border-radius: 5px;
}

.prev, .next {
	cursor: pointer;
	position: absolute;
	top: 50%;
	width: auto;
	padding: 16px;
	margin-top: -22px;
	color: white;
	font-weight: bold;
	font-size: 18px;
	transition: 0.6s ease;
	user-select: none;
	z-index: 99;
}

.next {
	right: 0;
}

.prev:hover, .next:hover {
	background-color: rgba(0, 0, 0, 0.8);
}

.text_center {
	font-size: 32px;
	font-weight: 700;
	color: #111;
}

.sub_title {
	margin-top: 11px;
	font-size: 1.2rem;
	color: #767676;
	text-align: center;
	line-height: 26px;
}
</style>

<body>
	<div id="container">
	<div id="wrap">
		<%@ include file="header.jsp"%>

	<div id="slideShow" class="promote">
			<div id="slides">
			<img src="images/promote_b.png" alt="">
<!-- 					<div class="slide promote_a active" aria-hidden="false" style="background-image: url('/static/images/promote_a.png');"> -->
				<div class="slide promote_a active" aria-hidden="false" style="display: block;">
					<div class="size_set">
						<p class="promote_a_title">
							맞춤형 <b>취업</b><br> <b>기업정보와 채용</b>까지
						</p>
						<p class="promote_a_sub">
							더 나은 일자리를 구하도록 제공합니다.<br>12wa~에서 이루세요.
						</p>
					</div>
				</div>
				
				<img src="images/promote_a.png" alt="">
<!-- 				  	 <div class="slide promote_b" aria-hidden="true" style="background-image: url('/static/images/promote_b.png');"> -->
				<div class="slide promote_b" aria-hidden="true" style="display: none;">
					<div class="size_set">
						<p class="promote_b_title">
							<b>당신의 취업이룸</b>을<br> 응원합니다.
						</p>
						<p class="promote_b_sub">
							더 나은 일자리를 구하도록 제공합니다.<br>12wa~에서 이루세요.
						</p>
					</div>
				</div>
				
				<button id="prev">&lang;</button>
				<button id="next">&rang;</button>
			</div>
		</div>

		<script type="text/javascript">
			$(document).ready(function() {
				$(".slide").not(".active").hide(); // 화면 로딩 후 첫번째 div를 제외한 나머지 숨김
			
// 				setInterval(nextSlide, 3000); // 3초마다 다음 슬라이드로 넘어감});
			});
			

			// 이전 슬라이드
			function prevSlide() {
				 var allSlides = $(".slide");
				 var currentIndex = allSlides.index($(".active"));

				allSlides.hide().removeClass("active");

				var newIndex = (currentIndex <= 0) ? allSlides.length - 1
						: currentIndex - 1;

				allSlides.eq(newIndex).show().addClass("active");
				return newIndex; // 슬라이드 인덱스를 반환
				
			}
			
			// 다음 슬라이드
			function nextSlide() {
				var allSlides = $(".slide");
				var currentIndex = allSlides.index($(".active"));

				allSlides.hide().removeClass("active");

				var newIndex = (currentIndex >= allSlides.length - 1) ? 0
						: currentIndex + 1;

				allSlides.eq(newIndex).show().addClass("active");
				return newIndex; // 슬라이드 인덱스를 반환
			}
			
            // 다음 슬라이드로 이동하고 텍스트 업데이트
            function nextSlideAndUpdateText() {
                var newIndex = nextSlide();
                updateText(newIndex); // 슬라이드가 변경될 때마다 텍스트 업데이트 함수 호출
            }
			
            // 이전 슬라이드로 이동하고 텍스트 업데이트
            function prevSlideAndUpdateText() {
                var newIndex = prevSlide();
                updateText(newIndex); // 슬라이드가 변경될 때마다 텍스트 업데이트 함수 호출
            }
			

			function updateText(slideIndex) {

			    // 슬라이드 이미지와 텍스트를 매핑하는 배열을 만듭니다.
			    const slideTextArray = [{
			    	 title: "맞춤형 <b>취업</b><br> <b>기업정보와 채용</b>까지",
                     sub: "더 나은 일자리를 구하도록 제공합니다.<br>12wa~에서 이루세요."
			    }, {
			    	 title: "<b>당신의 취업이룸</b>을<br> 응원합니다.",
                     sub: "더 나은 일자리를 구하도록 제공합니다.<br>12wa~에서 이루세요."
			    }];

			    // 현재 슬라이드 인덱스에 해당하는 텍스트 가져오기
			    const slideText = slideTextArray[slideIndex];
				
			    // 가져온 텍스트를 해당하는 요소에 업데이트합니다.
			    const titleElement = $(".slide.active .promote_title");
			    const subElement = $(".slide.active .promote_sub");

			    titleElement.textContent = slideText.title; // textContent로 텍스트 업데이트
			    subElement.textContent = slideText.sub; // textContent로 텍스트 업데이트
			}

			// 이전 버튼과 다음 버튼을 클릭할 때 마다 업데이트 함수 호출
			$('#prev').on('click', prevSlide)
			$('#next').on('click', nextSlide)


		</script>
		
				<center>
			<h3 class="text_center">구인구직 사이트 12wa~ 사업소개</h3>
		</center>
		<p class="sub_title">2024년 5월 31일 「구직자 취업촉진 및 채용공고」‘12wa~’가
			시행되었습니다.</p>

    <div id="contents">
    
      <div id="tabMenu">
        <input type="radio" id="tab1" name="tabs" checked>
        <label for="tab1">공지사항</label>
        <input type="radio" id="tab2" name="tabs" onclick="getNaverNews()">
        <label for="tab2">IT/뉴스</label>
        <input type="radio" id="tab3" name="tabs" onclick="getYouTube()">
        <label for="tab3">YouTube</label>
              
        <div id="notice" class="tabContent">
          <h2>공지사항 내용입니다.</h2>     
          <ul>        
         <c:set var="mainCount" value="0" />
         <c:forEach var="board" items="${requestScope.noticeList}" varStatus="status">
             <c:if test="${mainCount < 5}">
                 <c:if test="${board.category eq 'main'}">
                     <c:set var="mainCount" value="${mainCount + 1}" />
                     <li style="cursor:pointer" onClick="gonoticeDetailForm(${board.n_no})">
                         ${board.subject}
                     </li>
                 </c:if>
             </c:if>
         </c:forEach>
          </ul>

        </div>
               <form name="noticeDetailForm" action="/noticeDetail.do"   method="post">
                  <!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
                  <input type="hidden" name="n_no"  value="${board.n_no}">
                                    
             </form>  
               
        <div id="gallery" class="tabContent">
          <h2>IT/뉴스 내용입니다.</h2>
          <ul id="headLine">
          </ul>
        </div> 
        
        <div id="youTube" class="tabContent">
          <h2>채용관련</h2>
          <ul id="youtubeList">
          </ul>
        </div>   
            
      </div>
      
      <div id="links">
        <ul>
          <li>
          	<c:choose>
          		<c:when test="${sessionScope.member=='company'}">
          			<b>업종별 희망인원, 지원 수</b>
          		</c:when>
          		<c:when test="${sessionScope.member=='admin'}">
          			<b>월별 가입자 수 추이</b>
          		</c:when>
          		<c:otherwise>
          			<b>업종별 공고,기업 수</b>
          		</c:otherwise>
          	</c:choose>
          	<c:if test="${sessionScope.member!='admin'}">
              <canvas id="gonggoChart" width="800px" height="262px"></canvas>
             </c:if>
          	<c:if test="${sessionScope.member=='admin'}">             
              <canvas id="MemberIn" width="800px" height="262px"></canvas>
            </c:if>
          </li> 
        </ul>
      </div>
          		 
	  <div id="links2">
	    <ul>
	    	<li>
	    		<div id="popular" style="font-family: Arial, sans-serif; font-size: 16px; line-height: 1.6; border: 1px solid #ccc; padding: 30px; border-radius: 30px; width: 350px; text-align:left; padding-left:70px;">
				    <div style="margin-bottom:30px"><b style="font-size: 20px; color: #007bff; font-weight: bold;">현재 인기 많은 TOP5 기업</b></div>
				    <c:forEach var="board" items="${requestScope.popularCom}" varStatus="status">
				        <div style="margin-bottom: 10px;">
				            <a style="color: #007bff; font-weight: bold; cursor:pointer;" onClick="gocompanyListDetailForm(${board.c_no});">${board.rnum}위</a> - <span style="cursor:pointer;"onClick="gocompanyListDetailForm(${board.c_no});">${board.name}</span> 
				        </div>
				    </c:forEach>
				    <div style=" margin-top: 30px; text-align:center;">
					    <input type="button" value="+더보기" onClick="location.replace('/companyList.do')" style="cursor:pointer;  background-color: #007bff; color:#fff ; border-radius:5px; opacity:0.7;">
					</div>
				</div>
	    	</li>
	        <li>
	            <canvas id="SalaryChart" width="400px" height="262px"></canvas>
	        </li>
	        <li>
	        	 <div class="recordsStatisticsRegionRatioContainer">
	        	 <c:if test="${sessionScope.member!='admin' }">
			        <div class="recordsStatisticsRegionRatioTitle" ><br>
			       </c:if>
			          		<c:if test="${sessionScope.member=='company'}">
			          			<b>지역별 인원 수</b>
			          		</c:if>
			          		<c:if test="${sessionScope.member!='company' and sessionScope.member!='admin'} ">
			          			<b>지역별 기업 수</b>
			          		</c:if>
			        	</div>
			         <c:if test="${sessionScope.member!='admin'}">	
			        	<div id="recordsStatisticsRegionRatio" style="width: 100%; height: 340px; margin: 0 auto;"></div>
			        </c:if>
			        <c:if test="${sessionScope.member=='admin'}">
			        	<canvas id="MemberRatio" width="400px" height="262px"></canvas>
			        </c:if>	
			        
			    </div>
	        </li>
	    </ul>
	</div>
<!--       기업 평균연봉 분포도(단위 : 만원) -->
<!-- 	            <canvas id="SalaryChart" width="400px" height="262px"></canvas> -->
    </div>  
    </div>
  </div> 
  <form name="companyListDetailForm" action="/companyListDetail.do"  method="post">
            <!-- 클릭한 행의 게시판 고유번호가 저장될 히든태그 선언 -->
            <input type="hidden" name="c_no" value="${board.c_no}">
         </form>
  
  
  <script>
  const memberValue = '${sessionScope.member}';
	let labels1, data1,text1,label1;
	if (memberValue === 'company') {
	    labels1 = ${empty Salary_Range ? 0 : Salary_Range};
	    data1 = ${empty Hope_Cnt?0:Hope_Cnt};
	    text1 = "희망 연봉 분포(단위: 만)";
	    label1 = "희망 인원";
	} 
	else if(memberValue==='admin'){
		labels1 = ${empty getSexRatio ? 0 : '["남", "여"]'};
		data1= ${empty getSexRatio ? 0 : [getSexRatio.male, getSexRatio.female]};
		text1= "남/녀 비율";
		label1="인원 수";
	}
	else {
	    labels1 = ${Range};
	    data1 = ${SalaryData};
	    text1 = "기업 연봉 분포(단위: 만)";
	    label1 = "기업 수"
	}
  
  const ctx1 = document.getElementById('SalaryChart').getContext('2d');

  console.log("12"+labels1);
  
  const SalaryChart = new Chart(ctx1, {
	    type: 'doughnut',
	    data: {
	      labels: labels1,
	      datasets: [
	    	 {
	        label: label1,
	        data: data1,
	        backgroundColor: [
	          'rgba(54, 162, 235, 0.6)',
	          'rgba(255, 99, 132, 0.6)',
	          'rgba(255, 206, 86, 0.6)',
	          'rgba(75, 192, 192, 0.6)',
	          'rgba(153, 102, 255, 0.6)',
	          'rgba(255, 159, 64, 0.6)',
	          'rgba(128, 0, 128, 0.6)',
	          'rgba(0, 0, 255, 0.6)',
	          'rgba(0, 128, 0, 0.6)'
	          
	        ],
	        borderColor: [
	          'rgba(54, 162, 235, 1)',
	          'rgba(255, 99, 132, 1)',
	          'rgba(255, 206, 86, 1)',
	          'rgba(75, 192, 192, 1)',
	          'rgba(153, 102, 255, 1)',
	          'rgba(255, 159, 64, 1)',
	          'rgba(128, 0, 128, 1)',
	          'rgba(0, 0, 255, 1)',
	          'rgba(0, 128, 0, 1)'
	        ],
	        borderWidth: 1,
	        hoverOffset: 50
	      }]
	    },
	    options: {
	      plugins: {
	    	  title: {
	    	        display: true,
	    	        text: text1,
	    	        color: 'black',
	    	        font: {
	    	          size: 18
	    	        },
	    	        padding: {
	    	          top: 10,
	    	          bottom: 10
	    	        }
	    	      },
	        legend: {
	          display: true,
	          position: 'bottom',
	          labels: {
	            color: 'black',
	            font: {
	              size: 14
	            },
	            boxWidth:10
	          }
	        },
	        tooltip: {
	          enabled: true,
	          backgroundColor: 'rgba(0, 0, 0, 0.7)',
	          titleColor: 'white',
	          bodyColor: 'white',
	          borderColor: 'white',
	          borderWidth: 1
	        }
	      },
	      animation: {
	        animateScale: true,
	        animateRotate: true
	      },
	      layout: {
	        padding: {
	          left: 20,
	          right: 20,
	          top: 20,
	          bottom: 20
	        }
	      }
	    }
	  });
  
if(memberValue!='admin'){
  const ctx2 = document.getElementById('gonggoChart').getContext('2d');
  let labels2, data2, data2_1, text2, label2, label2_1;
  
	if (memberValue == 'company') {
	    labels2 = ${empty Hope_Field ? 0 : Hope_Field};
	    data2 = ${empty Hope_PerCnt ? 0 : Hope_PerCnt};
	    data2_1 = ${empty Apply_Cnt ? 0 : Apply_Cnt};
		text2 = "업종별 희망인원, 지원 수";
	    label2 = "희망 인원"
	    label2_1 = "지원 수"
	} else {
	    labels2 = ${Field};
	    data2 = ${gonggoCnt};
	    data2_1 = ${companyCnt};
	    text2 = "업종별 공고, 기업 수";
	    label2 = "공고 수"
	    label2_1 = "기업 수"
	}
  
  const gonggoChart = new Chart(ctx2, {
	    type: 'bar',
	    data: {
	        labels: labels2,
	        datasets: [
	            {
	                label: label2,
	                data: data2,
	                backgroundColor: '#00C7E2'
	            },
	            {
	                label: label2_1,
	                data: data2_1,
	                backgroundColor: '#FF7DA8'
	            }
	        ]
	    },
	    options: {
	        plugins: {
	            legend: {
	                labels: {
	                    boxWidth: 10 // 여기에서 범례 항목의 너비를 설정합니다.
	                }
	            }
	        }
	    }
	});
}
else{
	const ctx3 = document.getElementById('MemberIn').getContext('2d');
  
	const MemberIn = new Chart(ctx3, {
	    type: 'line',
	    data: {
	        labels: ${month},
	        datasets: [
	            {
	                label: '개인 가입 인원',
	                data: ${person_count},
	                backgroundColor: 'rgb(255, 99, 132)',
	                borderWidth: 1,
	                fill: false
	            },
	            {
	                label: '기업 가입 인원',
	                data: ${company_count},
	                backgroundColor: 'rgb(75, 192, 192)',
	                borderWidth: 1,
	                fill: false
	            }
	            ]
	    	},
	            options:{
	            	scales:{
	            		x: {
	            			beginAtZero : true
	            		},
	            		y:{
	            			beginAtZero : true
	            		}
	            	}
	            }
			});
}
const ctx4 = document.getElementById('MemberRatio').getContext('2d');
  
  const MemberRatio = new Chart(ctx4, {
	    type: 'doughnut',
	    data: {
	      labels: ${empty getMemberRatio ? 0 :'["개인","기업"]'},
	      datasets: [
	    	 {
	        label: "수",
	        data: [${getMemberRatio.person}, ${getMemberRatio.company}],
	        backgroundColor: [
	          'rgba(255, 206, 86, 0.6)',
	          'rgba(75, 192, 192, 0.6)',
	          'rgba(153, 102, 255, 0.6)',
	          'rgba(255, 159, 64, 0.6)',
	          'rgba(128, 0, 128, 0.6)',
	          'rgba(0, 0, 255, 0.6)',
	          'rgba(0, 128, 0, 0.6)'
	          
	        ],
	        borderColor: [
	          'rgba(255, 206, 86, 1)',
	          'rgba(75, 192, 192, 1)',
	          'rgba(153, 102, 255, 1)',
	          'rgba(255, 159, 64, 1)',
	          'rgba(128, 0, 128, 1)',
	          'rgba(0, 0, 255, 1)',
	          'rgba(0, 128, 0, 1)'
	        ],
	        borderWidth: 1,
	        hoverOffset: 50
	      }]
	    },
	    options: {
	      plugins: {
	    	  title: {
	    	        display: true,
	    	        text: "회원 비율",
	    	        color: 'black',
	    	        font: {
	    	          size: 18
	    	        },
	    	        padding: {
	    	          top: 10,
	    	          bottom: 10
	    	        }
	    	      },
	        legend: {
	          display: true,
	          position: 'bottom',
	          labels: {
	            color: 'black',
	            font: {
	              size: 14
	            },
	            boxWidth:10
	          }
	        },
	        tooltip: {
	          enabled: true,
	          backgroundColor: 'rgba(0, 0, 0, 0.7)',
	          titleColor: 'white',
	          bodyColor: 'white',
	          borderColor: 'white',
	          borderWidth: 1
	        }
	      },
	      animation: {
	        animateScale: true,
	        animateRotate: true
	      },
	      layout: {
	        padding: {
	          left: 20,
	          right: 20,
	          top: 20,
	          bottom: 20
	        }
	      }
	    }
	  });
  //======================================================//
// 	    type: 'bar',
// 	    data: {
// 	      labels: ${Field},
// 	      datasets: [{
// 	        label: '공고 수',
// 	        data: ${gonggoCnt},
// 	        backgroundColor: [
// 	          'rgba(255, 99, 132, 0.6)',
// 	          'rgba(54, 162, 235, 0.6)',
// 	          'rgba(255, 206, 86, 0.6)',
// 	          'rgba(75, 192, 192, 0.6)',
// 	          'rgba(153, 102, 255, 0.6)',
// 	          'rgba(255, 159, 64, 0.6)',
// 	          'rgba(128, 0, 128, 0.6)',
// 	          'rgba(0, 0, 255, 0.6)'
// 	        ],
// 	        borderColor: [
// 	          'rgba(255, 99, 132, 1)',
// 	          'rgba(54, 162, 235, 1)',
// 	          'rgba(255, 206, 86, 1)',
// 	          'rgba(75, 192, 192, 1)',
// 	          'rgba(153, 102, 255, 1)',
// 	          'rgba(255, 159, 64, 1)',
// 	          'rgba(128, 0, 128, 1)',
// 	          'rgba(0, 0, 255, 1)'
// 	        ],
// 	        borderWidth: 1,
// 	        hoverOffset: 50
// 	      }]
// 	    },
// 	    options: {
// 	      plugins: {
// 	        legend: {
// 	          display: true,
// 	          position: 'top',
// 	          labels: {
// 	            color: 'black',
// 	            font: {
// 	              size: 14
// 	            },
// 	    		boxWidth:10
// 	          }
// 	        },
// 	        tooltip: {
// 	          enabled: true,
// 	          backgroundColor: 'rgba(0, 0, 0, 0.7)',
// 	          titleColor: 'white',
// 	          bodyColor: 'white',
// 	          borderColor: 'white',
// 	          borderWidth: 1
// 	        }
// 	      },
// 	      animation: {
// 	        animateScale: true,
// 	        animateRotate: true
// 	      },
// 	      layout: {
// 	        padding: {
// 	          left: 20,
// 	          right: 20,
// 	          top: 20,
// 	          bottom: 20
// 	        }
// 	      }
// 	    }
// 	  });


</script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	function getNaverNews(){
		// naver 탭에 대한 AJAX 요청
		if(!$('#headLine').text().trim()){
			$.ajax({
			    type: "GET",
			    url: "/naver",
			    dataType: "json",
			    success: function (data) {
			      console.log(data);
			      if (!data.errorMessage) {
			        var textList = data.reulst.textList; 
			        var imgList = data.reulst.imgList; 
			        var hrefList = data.reulst.hrefList; 
			        var innerHtml = '';
			        for(var i = 0; i < textList.length; i++) {
			          innerHtml += '<li>';
			          innerHtml +=     '<a href="' + hrefList[i] + '" data-clk="clart">';
			          innerHtml +=         '<div class="news-item">';
			          innerHtml +=             '<div class="news-thumbnail">';
			          innerHtml +=                 '<img src="' + imgList[i] + '" alt="' + textList[i] + '">';
			          innerHtml +=             '</div>';
			          innerHtml +=             '<div class="news-text">';
			          innerHtml +=                 '<strong>' + textList[i] + '</strong>';
			          innerHtml +=             '</div>';
			          innerHtml +=         '</div>';
			          innerHtml +=     '</a>';
			          innerHtml += '</li>';      
			        }
			        $('#headLine').html(innerHtml);
			      } else {
			        alert('Error !!');
			      }
			    },
			    error: function (error) {
			      console.log(error);
			    }
		  	});
		}
		
	}
	
	function getYouTube(){
		
		console.log($('#youtubeList').html())
		
		if(!$('#youtubeList').text().trim()){
		
		// YouTube 탭에 대한 AJAX 요청
		$.ajax({
		    type: "GET",
		    url: "/YouTube", // 실제 YouTube 크롤링 URL을 입력해주세요
		    dataType: "json",
		    success: function (data) {
		      console.log(data);
		      if (!data.errorMessage) {
		        var videoList = data.reulst.videoList; 
		        var innerHtml = '';
		        for(var i = 0; i < videoList.length; i++) {
		          innerHtml += '<li>';
		          innerHtml +=     '<a href="' + videoList[i].url + '" data-clk="clart">';
		          innerHtml +=         '<div class="video-item">';
		          innerHtml +=             '<div class="video-thumbnail">';
		          innerHtml +=                 '<img src="' + videoList[i].thumbnail + '" alt="' + videoList[i].title + '">';
		          innerHtml +=             '</div>';
		          innerHtml +=             '<div class="video-text">';
		          innerHtml +=                 '<strong>' + videoList[i].title + '</strong>';
		          innerHtml +=             '</div>';
		          innerHtml +=         '</div>';
		          innerHtml +=     '</a>';
		          innerHtml += '</li>';      
		        }
		        $('#youtubeList').html(innerHtml);
		      } else {
		        alert('Error !!');
		      }
		    },
		    error: function (error) {
		      console.log(error);
		    }
		  });
		}
	}

</script>

  <style>
.news-item {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.news-thumbnail {
  flex: 0 0 auto;
  margin-right: 10px;
}

.news-thumbnail img {
  width: 100px;
  height: 65px;
}

.news-text strong {
  font-weight: bold;
  font-size: 16px;
}

.video-item {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}

.video-thumbnail {
  flex: 0 0 auto;
  margin-right: 10px;
}

.video-thumbnail img {
  width: 100px;
  height: 65px;
}

.video-text strong {
  font-weight: bold;
  font-size: 16px;
}
</style>
 <%@include file="/WEB-INF/views/common.jsp" %>
  <%@ include file="footer.jsp" %>
</body>

</html>
