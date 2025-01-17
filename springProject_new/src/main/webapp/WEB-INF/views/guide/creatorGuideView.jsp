<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/guide.css" type="text/css">  
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css" type="text/css"> 

<%-- <div class='menu2 guide_container'>
	<div class="guide_item" id="guide-left">이용안내</div>
	<div class="guide_item" id="guide-right1" onclick="location.href='${pageContext.request.contextPath}/guide/projectStandard.do'">프로젝트 심사기준</div>
	<div class="guide_item" id="guide-right2" onclick="location.href='${pageContext.request.contextPath}/guide/supporterGuide.do'">후원자 가이드</div>
	<div class="guide_item" id="guide-right3" onclick="location.href='${pageContext.request.contextPath}/guide/creatorGuide.do'">창작자 가이드</div>
</div> --%>
<div class='menu2'>
	<ul>
		<!-- if문 걸어서 현재 페이지에 따라 현재 링크 나오도록 -->
		<li>
			<a class="delete_line">이용안내</a>
		</li>
		<li style="float: right">
		<a href="${pageContext.request.contextPath}/guide/projectStandard.do" class="delete_line">프로젝트 심사 기준</a>
		</li>	
		<li style="float: right">
		<a href="${pageContext.request.contextPath}/guide/supporterGuide.do" class="delete_line">후원자 가이드</a>
		</li>	
		<li style="float: right; margin-left: 140px;">
		<a href="${pageContext.request.contextPath}/guide/creatorGuide.do" class="delete_line">창작자 가이드</a>
		</li>
	</ul>
</div>

<br><br>
  <div class="article-container">
    <article class="static article">
    <h1>창작자 가이드</h1>
	<p>펀딩어드벤처 프로젝트가 처음인가요? 창작자 가이드를 통해 펀딩어드벤처 진행 과정을 한눈에 살펴보세요.</p>

<div style="display:flex">
	
	<div>
	<h3>&nbsp;&nbsp;&nbsp;&nbsp;프로젝트 준비</h3>
<ol>
<li><a href="#ChapterA-01">펀딩 예산 수립</a></li>
<li><a href="#ChapterA-02">목표 금액 설정</a></li>
<li><a href="#ChapterA-03">선물 아이디어</a></li>
<li><a href="#ChapterA-04">선물 구성 방법</a></li>
<li><a href="#ChapterA-05">펀딩 일정 계획</a></li>
<li><a href="#ChapterA-06">정산 일정</a></li>
</ol>
</div>
	
	<div>
		<h3>&nbsp;&nbsp;&nbsp;&nbsp;스토리 작성</h3>
<ol>
<li><a href="#ChapterB-01">대표 영상 및 이미지</a></li>
<li><a href="#ChapterB-02">창작자 소개</a></li>
<li><a href="#ChapterB-03">프로젝트 계기 및 취지</a></li>
<li><a href="#ChapterB-04">프로젝트 소개</a></li>
<li><a href="#ChapterB-05">프로젝트 예산</a></li>
<li><a href="#ChapterB-06">선물 소개</a></li>
<li><a href="#ChapterB-07">프로젝트 일정</a></li>
<li><a href="#ChapterB-08">후원자 안내</a></li>
</ol></div>
	
<div>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;홍보</h3>
<ol>
<li><a href="#ChapterC-01">홍보 계획하기</a></li>
<li><a href="#ChapterC-02">초반 후원 독려하기</a></li>
<li><a href="#ChapterC-03">프로젝트 소개하기</a></li>
<li><a href="#ChapterC-04">SNS 활용방법</a></li>
<li><a href="#ChapterC-05">더 많은 사람에게 알리기</a></li>
<li><a href="#ChapterC-06">이벤트 진행하기</a></li>
<li><a href="#ChapterC-07">오프라인을 활용하세요</a></li>
<li><a href="#ChapterC-08">대시보드 활용</a></li>
</ol></div>

<div>
<h3>&nbsp;&nbsp;&nbsp;&nbsp;소통</h3>
<ol>
<li><a href="#ChapterD-01">후원자와 소통</a></li>
<li><a href="#ChapterD-01">커뮤니티 활용</a></li>
<li><a href="#ChapterD-01">메일/메시지 활용</a></li>
<li><a href="#ChapterD-01">서베이 활용</a></li>
</ol>

<h3>&nbsp;&nbsp;&nbsp;&nbsp;전달</h3>
<ol>
<li><a href="#ChapterE-01">배송 가이드</a></li>
</ol></div>


</div>
<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>

<h2><a name="ChapterA-01">1.펀딩 예산 수립</a></h2>
<p>프로젝트를 준비할 때 가장 먼저 준비해야 하는 것은 예산을 짜는 것입니다. 어떤 예산 항목을 고려해야 하고 어떻게 짜야 하는지 알아보겠습니다.</p>
<h3><strong>제작 예산에 고려해야 하는 항목</strong></h3>
<ul>
<li>제작 예산 - 최소제작비 기준</li>
<li>배송비와 포장비</li>
<li>인건비</li>
<li>플랫폼 수수료</li>
<li>결제 수수료</li>
<li>부가세</li>
<li>예비비</li>
</ul>

<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>

<h2><a name="ChapterA-02">2.목표 금액 설정하기</a></h2>
<br>
<p>목표 금액을 너무 높게 설정하면 달성하기 어렵고, 너무 낮게 설정하면 목표 금액을 달성하고도 손실을 볼 수 있기 때문에 세심한 주의가 필요합니다. 특히 한 번 설정되어 론치 된 목표 금액은 다시 수정할 수 없기 때문에 더욱 주의해야 하는데요. 프로젝트 성공 가능성을 높이면서도, 손해 보지 않을 수 있는 적절한 목표 금액 설정 방법을 알아보겠습니다.</p>
<br>
<h3><strong>1)예산을 기준으로 설정하기</strong></h3>
<p>펀딩 예산 시트에서 계산된 펀딩 예산을 목표 금액으로 설정할 수도 있지만, 정말 내가 달성할 수 있는 금액일지 예측해 보고 목표 금액을 조정하는 것도 좋은 방법입니다. 아직 펀딩 예산을 설정하지 않으셨다면 펀딩 예산 설정 게시글을 먼저 참고하세요!</p>
<h3><strong>2)예상 후원자 수를 기준으로 설정하기</strong></h3>
<p>성사 금액을 아주 간단하게 예측해보는 방법도 있습니다. 확실히 후원할 것으로 예상되는 후원자와 평균 리워드 금액으로 예상 성사 금액을 계산하는 방식입니다.</p>
<h2><strong>예상 후원자 수 x 평균 리워드 금액 x 2 = 성사 금액</strong></h2>

<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>

<h2><a name="ChapterA-03">3.선물 아이디어</a></h2>
<p>펀딩어드벤처 후원자들은 단순히 제품이나 콘텐츠를 받기 위해서만 후원하는 것이 아니라 창작자의 취지와 아이디어에 공감하여 제작비 모금에 참여하는 것이기 때문에, 응원의 뜻에서 통크게 고액을 후원하는 경우도 많습니다. 이들은 창작자가 준비한 다양한 선물을 선택하여 프로젝트를 후원하는데요. 이런 선물 구성에는 제작하려는 프로젝트의 창작물은 물론, 후원의 가치를 더할 수 있는 다양한 서비스나 경험을 포함할 수 있습니다. 바로 이 부분이 후원자가 펀딩어드벤처에서만 경험할 수 있는 특별함입니다. </p>
<br>
<p>예를 들어 수달 창작자가 진행한 만화 <존잘식당> 메이킹 북 제작 프로젝트는 최종 창작물인 '메이킹 북' 뿐만 아니라, 원하는 인물을 직접 그려주는 '작품 의뢰', 1년 동안 한 달에 한 번 4컷만화를 전달하는 '멤버십'은 물론 작가와 함께 떠나는 '봄 소풍'을 선물에 포함하여 다양한 가치의 선물을 제안했습니다. 만약 최종 창작물인 '메이킹 북'만 전달하는 12,000원 선물만 제시했다면, 해당 프로젝트를 보고 그 이상의 후원 가치를 느낀 후원자들을 놓쳤겠죠.</p>

<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>

<h2><a name="ChapterA-04">4.선물 구성 방법</a></h2>
<p>어떤 선물들을 제공할지 정하셨다면 각각의 선물들을 조합해 다양한 선물 구성을 만들 차례입니다. 과일 바구니를 떠올리면 이해하기 쉬우실 텐데요. 각각의 과일(선물)들을 조합해 여러 개의 과일 바구니(선물 구성)를 만든다고 생각하시면 됩니다. 그럼 어떻게 해야 매력적으로 선물을 구성할 수 있을까요? 후원자의 마음을 훔칠 수 있는 매력적인 선물 구성 방법을 참고해보세요.</p>
<h3><strong>1)얼리버드 구성하기</strong></h3>
<p>펀딩어드벤처에서는 프로젝트 론치 3일 이내에 전체 성사 금액의 약 37%가 모금되는 만큼 펀딩 초기에 최대한 많은 후원자가 참여할 수 있도록 해야 합니다. 이때 유용한 방법이 얼리버드 선물을 구성하는 것입니다. 얼리버드는 가격이나 추가 서비스 등의 혜택을 한정 수량으로 더해 잠재후원자들이 펀딩 초기에 적극적으로 참여할 수 있도록 독려할 수 있습니다.</p>
<h3><strong>2)저가부터 고가까지 다양하게 구성하기</strong></h3>
<p>후원자들이 부담 없이 가볍게 참여할 수 있는 금액부터 진성 팬들을 위한 고가 선물까지 여러 단계의 금액으로 선물을 구성할 수 있습니다. 낮은 금액대의 선물 구성은 많은 후원자를 모을 수 있지만 목표 금액 달성에 크게 기여하기는 어려울 수 있습니다. 그렇다고 높은 금액대로만 구성한다면 인기 없는 프로젝트가 될 가능성이 높죠. 그렇기 때문에 다양한 금액대로 선물을 제시해 최대한 많은 후원자의 마음을 잡을 수 있어야 합니다.</p>
<h3><strong>3)세트로 구성하기</strong></h3>
<p>창작물이 소모품을 포함하고 있거나, 다른 이에게 선물하기 좋은 제품이라면 여러 개를 세트로 묶어 구성하는 것도 좋은 방법입니다.</p>

<p>&nbsp;</p>
<p>&nbsp;</p>
<hr>
<h2><a name="ChapterA-05">5.펀딩 일정 계획</a></h2>
<p>펀딩어드벤처에서 설정할 수 있는 펀딩 기간은 최대 60일이며, 마감일을 기준으로 목표 금액 달성 여부를 판단합니다. 프로젝트가 마감되면 더는 펀딩에 참여할 수 없기 때문에 최대한 많은 후원자가 참여할 수 있도록 적절한 펀딩 기간 설정이 필요합니다.
</p>
<h3><strong>펀딩어드벤처 권장 펀딩 기간은 30일</strong></h3>
<p>펀딩 기간을 너무 짧게 설정하면 뒤늦게 프로젝트를 알게 된 잠재 후원자들이 참여하고 싶어도 할 수 없는 안타까운 상황이 발생할 수 있습니다. 반대로 펀딩 기간이 너무 길면 프로젝트가 지루해지고, 자신 없어 보일 수 있습니다. 그럼 어느 정도가 적절한 기간일까요?</p>
<p>위 차트는 목표 금액 달성에 성공한 프로젝트들이 펀딩 기간을 몇 일로 설정했는지를 보여줍니다. X 축은 펀딩 기간, Y축은 프로젝트 수를 나타냅니다. 결론적으로 성공한 프로젝트의 70~80%가 펀딩 기간을 30일로 설정한 것을 볼 수 있습니다. 그렇기 때문에 특별한 이유가 없다면 적절한 펀딩 기간으로 30일을 권장하고 있습니다.</p>
<h3><strong>시의성이 있거나 제작비가 크다면?</strong></h3>
<p>시의성이 중요하거나 필요한 제작비가 큰 프로젝트의 경우에는 권장 펀딩 기간을 따르기보다 창작자의 상황에 맞게 설정하시는 것이 좋습니다. 예를 들어 패션이나 푸드와 같이 계절성이 중요한 제품은 후원자가 받는 제품을 받는 시점을 고려해야 합니다. 게임, 영화와 같이 제작비의 규모가 큰 프로젝트의 경우에는 펀딩 기간을 넉넉히 가져가되, 프로젝트가 지루해지지 않도록 지속적인 콘텐츠 업데이트와 이벤트를 미리 준비하셔야 합니다.</p>
<h3><strong>펀딩 일정 산정하기</strong></h3>
<p>펀딩 일정을 산정할 때에는 심사를 받는 기간부터 시작해서 후원자에게 선물을 전달하는 날까지 프로젝트 종료 전반을 고려해야 합니다. 펀딩어드벤처 프로젝트의 과정은 프로젝트 주요 일정이 어떻게 되나요? 를 참고해주세요.</p>
<p>심사 신청부터 공개 예정 기능을 고려해 론치 일정을 설정하고, 이후 정산 일정까지 고려하기에는 처음 하는 펀딩하는 분들에게는 어려움이 있을 수 있습니다. 하지만 펀딩 일정 시트를 활용하면 한 눈에 전체 일정을 계산해 볼 수 있기 때문에 프로젝트를 계획하기 한결 수월합니다.
</p>
<p><strong>충분한 제작 기간을 고려하여 정산일 이후의 선물 제작 완료일과 배송 예정일을 산정하세요. 정산일 이후 1~2개월 이상의 제작 기간을 고려하시는 것을 권장합니다. (프로젝트 마다 상이할 수 있습니다.)</strong></p>


        </article>
        </div>
         