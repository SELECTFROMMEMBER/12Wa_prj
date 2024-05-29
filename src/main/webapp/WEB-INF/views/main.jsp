<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>12Wa~</title>
  <script >
function gonoticeDetailForm(n_no){
    $("[name='noticeDetailForm']").find("[name='n_no']").val(n_no);

     document.noticeDetailForm.submit();
 
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
    padding: 75px 0 0 170px;
    background: url(/static/image/photo-3.png) no-repeat right bottom;
}


	.promote_a_title {
    font-size: 40px;
    font-weight: 200;
    color: #111;
    text-align: justify;
    line-height: 48px;
}

	.promote_a_title b {
    font-weight: 700 !important;
}

	.promote_a_sub {
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

	.promote_a_btn:hover {
    text-decoration: underline;
}

	.promote_b {
    padding: 75px 0 0 700px;
    background: url(/static/image/photo-2.png) no-repeat right bottom;
}

	.promote .bxslider {
    overflow: hidden;
    border-radius: 15px;

</style>

<body>
	<div id="container">
		<%@ include file="header.jsp"%>

		<div id="slideShow">
			<div id="slides">
				
				<img src="images/photo-2.png" alt="">
				<li class="promote_a" aria-hidden="true"
					style="float: none; list-style: none; position: absolute; width: 1180px; z-index: 0; display: none;">
					<p class="promote_a_title">
						맞춤형 <b>취업지원</b><br> <b>소득지원 혜택</b>까지
					</p>
					<p class="promote_a_sub">
						더 나은 일자리를 구하도록 제공합니다.<br>취업이룸에서 이루세요.
					</p>
				</li> 
				
				<img src="images/photo-3.png" alt="">
				<li class="promote_b" aria-hidden="false"
					style="float: none; list-style: none; position: absolute; width: 1180px; z-index: 50; display: list-item;">
					<div class="size_set">

						<p class="promote_a_title">
							<b>당신의 취업이룸</b>을<br> 응원합니다.
						</p>
						
						<p class="promote_a_sub">
							더 나은 일자리를 구하도록 제공합니다.<br>12wa~에서 이루세요.
						</p>
					</div>
				</li>
				<button id="prev">&lang;</button>
				<button id="next">&rang;</button>
			</div>
		</div>

		<script type="text/javascript">
			$(document).ready(function() {
				$(".mySlideDiv").not(".active").hide(); //화면 로딩 후 첫번째 div를 제외한 나머지 숨김

				setInterval(nextSlide, 3000); //3초(3000)마다 다음 슬라이드로 넘어감
			});

			//이전 슬라이드
			function prevSlide() {
				$(".mySlideDiv").hide(); //모든 div 숨김
				var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
				var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수

				//반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
				$(".mySlideDiv").each(function(index, item) {
					if ($(this).hasClass("active")) {
						currentIndex = index;
					}

				});

				//새롭게 나타낼 div의 index
				var newIndex = 0;

				if (currentIndex <= 0) {
					//현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
					newIndex = allSlide.length - 1;
				} else {
					//현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
					newIndex = currentIndex - 1;
				}

				//모든 div에서 active 클래스 제거
				$(".mySlideDiv").removeClass("active");

				//새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
				$(".mySlideDiv").eq(newIndex).addClass("active");
				$(".mySlideDiv").eq(newIndex).show();

			}

			//다음 슬라이드
			function nextSlide() {
				$(".mySlideDiv").hide();
				var allSlide = $(".mySlideDiv");
				var currentIndex = 0;

				$(".mySlideDiv").each(function(index, item) {
					if ($(this).hasClass("active")) {
						currentIndex = index;
					}

				});

				var newIndex = 0;

				if (currentIndex >= allSlide.length - 1) {
					//현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
					newIndex = 0;
				} else {
					//현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
					newIndex = currentIndex + 1;
				}

				$(".mySlideDiv").removeClass("active");
				$(".mySlideDiv").eq(newIndex).addClass("active");
				$(".mySlideDiv").eq(newIndex).show();

			}
		</script>

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
            	기업 평균연봉 분포도(단위 : 만원)
              <canvas id="SalaryChart" width="400" height="400"></canvas>
          </li>
          
          <li>
            	업종별 채용공고
              <canvas id="gonggoChart" width="400" height="400"></canvas>
            </a>            
          </li> 
<!--           <li> -->
<!--             <a href="#"> -->
<!--               <span id="quick-icon3"></span> -->
<!--               <p>문의하기 </p> -->
<!--             </a>             -->
<!--           </li> -->
        </ul>
      </div>
    </div>  
  </div> 
  
  
  <canvas id="myChart" width="400" height="400"></canvas>
  
  
  <script>
  
  const ctx1 = document.getElementById('SalaryChart').getContext('2d');

  const SalaryChart = new Chart(ctx1, {
	    type: 'doughnut',
	    data: {
	      labels: ${Range},
	      datasets: [{
	        label: '기업 수',
	        data: ${SalaryData},
	        backgroundColor: [
	          'rgba(255, 99, 132, 0.6)',
	          'rgba(54, 162, 235, 0.6)',
	          'rgba(255, 206, 86, 0.6)',
	          'rgba(75, 192, 192, 0.6)',
	          'rgba(153, 102, 255, 0.6)',
	          'rgba(255, 159, 64, 0.6)',
	          'rgba(128, 0, 128, 0.6)',
	          'rgba(0, 0, 255, 0.6)'
	        ],
	        borderColor: [
	          'rgba(255, 99, 132, 1)',
	          'rgba(54, 162, 235, 1)',
	          'rgba(255, 206, 86, 1)',
	          'rgba(75, 192, 192, 1)',
	          'rgba(153, 102, 255, 1)',
	          'rgba(255, 159, 64, 1)',
	          'rgba(128, 0, 128, 1)',
	          'rgba(0, 0, 255, 1)'
	        ],
	        borderWidth: 1,
	        hoverOffset: 50
	      }]
	    },
	    options: {
	      plugins: {
	        legend: {
	          display: true,
	          position: 'right',
	          labels: {
	            color: 'black',
	            font: {
	              size: 14
	            }
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
  

  const ctx2 = document.getElementById('gonggoChart').getContext('2d');
  const gonggoChart = new Chart(ctx2, {
	    type: 'doughnut',
	    data: {
	      labels: ${Field},
	      datasets: [{
	        label: '공고 수',
	        data: ${gonggoCnt},
	        backgroundColor: [
	          'rgba(255, 99, 132, 0.6)',
	          'rgba(54, 162, 235, 0.6)',
	          'rgba(255, 206, 86, 0.6)',
	          'rgba(75, 192, 192, 0.6)',
	          'rgba(153, 102, 255, 0.6)',
	          'rgba(255, 159, 64, 0.6)',
	          'rgba(128, 0, 128, 0.6)',
	          'rgba(0, 0, 255, 0.6)'
	        ],
	        borderColor: [
	          'rgba(255, 99, 132, 1)',
	          'rgba(54, 162, 235, 1)',
	          'rgba(255, 206, 86, 1)',
	          'rgba(75, 192, 192, 1)',
	          'rgba(153, 102, 255, 1)',
	          'rgba(255, 159, 64, 1)',
	          'rgba(128, 0, 128, 1)',
	          'rgba(0, 0, 255, 1)'
	        ],
	        borderWidth: 1,
	        hoverOffset: 50
	      }]
	    },
	    options: {
	      plugins: {
	        legend: {
	          display: false,
	          position: 'right',
	          labels: {
	            color: 'black',
	            font: {
	              size: 14
	            }
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
<%@ include file="/WEB-INF/views/common.jsp"%> 
  <%@ include file="footer.jsp" %>
</body>
</html>
