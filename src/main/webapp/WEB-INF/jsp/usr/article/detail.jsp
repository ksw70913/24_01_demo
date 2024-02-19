<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="ARTICLE DETAIL"></c:set>
<%@ include file="../common/head.jspf"%>

<!-- <iframe src="http://localhost:8081/usr/article/doIncreaseHitCountRd?id=372" frameborder="0"></iframe> -->

<!-- 변수 -->
<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.memberId = parseInt('${loginedMemberId}');
	
	console.log(params);
	console.log(params.memberId);
	
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	var isAlreadyAddBadRp = ${isAlreadyAddBadRp};
	
	
</script>

<!-- 조회수 -->
<script>
	function ArticleDetail__doIncreaseHitCount() {
		const localStorageKey = 'article__' + params.id + '__alreadyView';

		if (localStorage.getItem(localStorageKey)) {
			return;
		}

		localStorage.setItem(localStorageKey, true);

		$.get('../article/doIncreaseHitCountRd', {
			id : params.id,
			ajaxMode : 'Y'
		}, function(data) {
			$('.article-detail__hit-count').empty().html(data.data1);
		}, 'json');
	}

	$(function() {
		// 		ArticleDetail__doIncreaseHitCount();
		setTimeout(ArticleDetail__doIncreaseHitCount, 2000);
	});
</script>

<!-- 좋아요 싫어요  -->
<script>
	<!-- 좋아요 싫어요 버튼	-->
	function checkRP() {
		if(isAlreadyAddGoodRp == true){
			$('#likeButton').toggleClass('btn-outline');
		}else if(isAlreadyAddBadRp == true){
			$('#DislikeButton').toggleClass('btn-outline');
		}else {
			return;
		}
	}
	

	
	function doGoodReaction(articleId) {
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}else {
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
					}
					
				}else {
					alert(data.msg);
				}
		
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);

			}
			
		});
	}
	
	
	
	function doBadReaction(articleId) {
		
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
	 $.ajax({
			url: '/usr/reactionPoint/doBadReaction',
			type: 'POST',
			data: {relTypeCode: 'article', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton = $('#likeButton');
					var likeCount = $('#likeCount');
					var DislikeButton = $('#DislikeButton');
					var DislikeCount = $('#DislikeCount');
					
					if(data.resultCode == 'S-1'){
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}else if(data.resultCode == 'S-2'){
						likeButton.toggleClass('btn-outline');
						likeCount.text(data.data1);
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
		
					}else {
						DislikeButton.toggleClass('btn-outline');
						DislikeCount.text(data.data2);
					}
			
				}else {
					alert(data.msg);
				}
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('싫어요 오류 발생 : ' + textStatus);
			}
			
		});
	}
	
	<!-- 댓글 -->
	<script>
			var ReplyWrite__submitDone = false;
			function ReplyWrite__submit(form) {
				if (ReplyWrite__submitDone) {
					alert('이미 처리중입니다');
					return;
				}
				console.log(123);
				
				console.log(form.body.value);
				
				if (form.body.value.length < 3) {
					alert('댓글은 3글자 이상 입력해');
					form.body.focus();
					return;
				}
				ReplyWrite__submitDone = true;
				form.submit();
			}
		</script>

<script>
	//-------------------------------//
	
		function checkRP2() {
		if(isAlreadyAddGoodRp == true){
			$('#likeButton2').toggleClass('btn-outline');
		}else if(isAlreadyAddBadRp == true){
			$('#DislikeButton2').toggleClass('btn-outline');
		}else {
			return;
		}
	}
	
		function doGoodReaction2(articleId) {
		if(isNaN(params.memberId) == true){
			if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
				var currentUri = encodeURIComponent(window.location.href);
				window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
			}
			return;
		}
		
		$.ajax({
			url: '/usr/reactionPoint/doGoodReaction',
			type: 'POST',
			data: {relTypeCode: 'reply', relId: articleId},
			dataType: 'json',
			success: function(data){
				console.log(data);
				console.log('data.data1Name : ' + data.data1Name);
				console.log('data.data1 : ' + data.data1);
				console.log('data.data2Name : ' + data.data2Name);
				console.log('data.data2 : ' + data.data2);
				if(data.resultCode.startsWith('S-')){
					var likeButton2 = $('#likeButton2');
					var likeCount2 = $('#likeCount2');
					var DislikeButton2 = $('#DislikeButton2');
					var DislikeCount2 = $('#DislikeCount2');
					
					if(data.resultCode == 'S-1'){
						likeButton2.toggleClass('btn-outline');
						likeCount2.text(data.data1);
					}else if(data.resultCode == 'S-2'){
						DislikeButton2.toggleClass('btn-outline');
						DislikeCount2.text(data.data2);
						likeButton2.toggleClass('btn-outline');
						likeCount2.text(data.data1);
					}else {
						likeButton2.toggleClass('btn-outline');
						likeCount2.text(data.data1);
					}
					
				}else {
					alert(data.msg);
				}
		    
			},
			error: function(jqXHR,textStatus,errorThrown) {
				alert('좋아요 오류 발생 : ' + textStatus);

			}
			
		});
	}
	
	
		function doBadReaction2(articleId) {
			if(isNaN(params.memberId) == true){
				if(confirm('로그인 해야해. 로그인 페이지로 가실???')){
					var currentUri = encodeURIComponent(window.location.href);
					window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
				}
				return;
			}
			
			$.ajax({
				url: '/usr/reactionPoint/doBadReaction',
				type: 'POST',
				data: {relTypeCode: 'reply', relId: articleId},
				dataType: 'json',
				success: function(data){
					console.log(data);
					console.log('data.data1Name : ' + data.data1Name);
					console.log('data.data1 : ' + data.data1);
					console.log('data.data2Name : ' + data.data2Name);
					console.log('data.data2 : ' + data.data2);
					if(data.resultCode.startsWith('S-')){
						var likeButton2 = $('#likeButton2');
						var likeCount2 = $('#likeCount2');
						var DislikeButton2 = $('#DislikeButton2');
						var DislikeCount2 = $('#DislikeCount2');
						
						if(data.resultCode == 'S-1'){
							likeButton2.toggleClass('btn-outline');
							likeCount2.text(data.data1);
						}else if(data.resultCode == 'S-2'){
							DislikeButton2.toggleClass('btn-outline');
							DislikeCount2.text(data.data2);
							likeButton2.toggleClass('btn-outline');
							likeCount2.text(data.data1);
						}else {
							likeButton2.toggleClass('btn-outline');
							likeCount2.text(data.data1);
						}
						
					}else {
						alert(data.msg);
					}
			    
				},
				error: function(jqXHR,textStatus,errorThrown) {
					alert('좋아요 오류 발생 : ' + textStatus);

				}
				
			});
		}
	
	
	
	
	$(function() {
		checkRP();
	});
	
	$(function() {
		checkRP2();
	});
</script>


<section class="mt-8 text-xl px-4">
	<div class="mx-auto">
		<table class="table-box-1" border="1">
			<tbody>
				<tr>
					<th>번호</th>
					<td>${article.id }${goodRP}${badRP}</td>
				</tr>
				<tr>
					<th>작성날짜</th>
					<td>${article.regDate }</td>
				</tr>
				<tr>
					<th>수정날짜</th>
					<td>${article.updateDate }</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${article.extra__writer }</td>
				</tr>
				<tr>
					<th>좋아요</th>
					<td id="likeCount">${article.goodReactionPoint }</td>
				</tr>
				<tr>
					<th>싫어요</th>
					<td id="DislikeCount">${article.badReactionPoint }</td>
				</tr>
				<tr>
					<th>추천 ${usersReaction }</th>
					<td>
						<!-- href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}" -->
						<button id="likeButton" class="btn btn-outline btn-success" onclick="doGoodReaction(${param.id})">좋아요</button>

						<button id="DislikeButton" class="btn btn-outline btn-error" onclick="doBadReaction(${param.id})">싫어요</button>
					</td>
				</tr>
				<tr>
					<th>조회수</th>
					<td><span class="article-detail__hit-count">${article.hitCount }</span></td>
				</tr>
				<tr>
					<th>제목</th>
					<td>${article.title }</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${article.body }</td>
				</tr>

			</tbody>
		</table>

		<div class="btns mt-5">
			<button class="btn btn-outline" type="button" onclick="history.back();">뒤로가기</button>
			<c:if test="${article.userCanModify }">
				<a class="btn btn-outline" href="../article/modify?id=${article.id }">수정</a>
			</c:if>
			<c:if test="${article.userCanDelete }">
				<a class="btn btn-outline" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
					href="../article/doDelete?id=${article.id }">삭제</a>
			</c:if>
		</div>
	</div>
</section>

<h2>댓글 리스트(${repliesCount })</h2>
<div>
	<table class="table-box-1 table" border="1">
		<colgroup>
			<col style="width: 10%" />
			<col style="width: 20%" />
			<col style="width: 60%" />
			<col style="width: 10%" />
		</colgroup>
		<thead>
			<tr>
				<th>날짜</th>
				<th>이름</th>
				<th>내용</th>
				<th>좋아요</th>
				<th>싫어요</th>
				<th>추천 ${usersReaction }</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="replies" items="${replies }">
				<tr class="hover">
					<td>${replies.regDate.substring(0,10) }</td>
					<td>${replies.memberId }</td>
					<td>${replies.body }</td>
					<td>${replies.goodReactionPoint }</td>
					<td>${replies.badReactionPoint }</td>
					<td>
						<!-- href="/usr/reactionPoint/doGoodReaction?relTypeCode=article&relId=${param.id }&replaceUri=${rq.currentUri}" -->
						<button id="likeButton2" class="btn btn-outline btn-success" onclick="doGoodReaction2(${param.id})">좋아요</button>

						<button id="DislikeButton2" class="btn btn-outline btn-error" onclick="doBadReaction2(${param.id})">싫어요</button>
					</td>
					<td><a class="btn btn-outline" href="../reply/modify?id=${reply.id }">수정</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>


<!-- Comments Form -->
<div class="card my-4">
	<h5 class="card-header">Leave a Comment:</h5>
	<div class="card-body">
		<form action="../reply/doWriteReply" method="POST" onsubmit="ReplyWrite__submit(this); return false;">
			<div class="form-group">
				<input type="hidden" name="memberId" value="${loginedMemberId }" /> <input type="hidden" name="relTypeCode"
					value="article" /> <input type="hidden" name="relId" value="${article.id }" />
				<textarea class="input input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
					placeholder="내용을 입력해주세요" name="body"> </textarea>
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>
</div>



<%@ include file="../common/foot.jspf"%>