<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"
	integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"
	integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13"
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
}

div {
border: 1px solid black;
text-align: center;
margin: 0px;
}

#graph>div{
float:left;
}

#agreeRatio{
background-color: aqua;
}
#disagreeRatio{
background-color:bisque;
}
</style>
</head>
<body>
	<div class="container w-100"
		style="max-width: 100%; padding: 0; margin: 0; position: relative;">
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<div class="container-fluid">
				<a class="navbar-brand" href="index.jsp">앞날의 지침</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
					aria-controls="navbarNavDropdown" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse justify-content-end"
					id="navbarNavDropdown">
					<ul class="navbar-nav">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">지출의 참견</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">선택의 참견</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">고객센터</a></li>
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#">회원가입</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
<!-- 게시글--------------------------------------------------------------------------------------------- -->
	<div id="viewContainer"  style="width:70%; margin: auto;">
		<div id="board_vIew" class="row">
		<div id="title" class="col-10">
		${dto.title }
		</div>
		<div id="view_Count" class="col-2">
		${dto.view_count }
		</div>	
		<div id="img_Box" class="col-5">
			<img src="files/${dto.fileName }" style="width: 100% ; height: 100%;" >
		</div>
		<div id="contents_Box" class="col-7">
			<div id="item">${dto.item}</div>
			<div id="contents">${dto.contents}</div>
		</div>
		<div id="item_price">전체 금액 : ${dto.item_price}</div>
		<div>
			<div id="graph" style="width:70%; margin:auto;">
				<div style="width:${agreeRatio}%;height:10px" id="agreeRatio"></div><div style="width:${disagreeRatio}%;height:10px" id="disagreeRatio"></div>
			</div>
			<form action="/write.brd1_reply">
			<input type="hidden" name="parent_seq" value=${dto.seq }>
				<div id="radio" style="margin-top:10px;">				
					<input type="radio" value="산다" name="agree">산다 : ${dto.agree_count }
					<input type="radio" value="만다" name="agree">만다 : ${dto.disagree_count }
				</div>
			</div>
<!-- 	댓글------------------------------------------------------------------------- -->
<!-- 댓글 작성--------------------------------------------------------------------------->
			<div id="replyWriteContainer">
				<div id="reply_Write" class="row">
					<div id="right" style="border:0px" class="col-9">	
						<div style="border:0px;text-align: left;" id="writer" >
							${nickname}
						<input type="hidden" name="nickname" value=${nickname }>
						</div>
						<div  style="border:0px">
							<input type="text" placehold="왜 그렇게 생각하나요?" style="width: 100%;" name="contents" id="contents_reply">
						</div>				
					</div>
					<div id="left" class="col-3" style="border:0px">
						<input type="submit" value="reply" id="reply">
					</div>
				</div>
			</div>
			<div id="btns" style="text-align: right;">
			<hr>
		</form>
<!-- --댓글 View------------------------------------------------------------------------------ -->
		<c:forEach var="i" items="${list }">
			<div calss="replyViewcontainer" class="row">
				<div class="col-2">${i.agree}</div>
				<div class="col-8">
					<div class="writer">작성자 : ${i.writer }</div>
					<input type="text" name="reply_contents" value=${i.contents} disabled >
					<input type="hidden" name="replySeqToUpdate" value=${i.seq } disabled >
					<div>${i.write_date }</div>
				</div>
				<div class="col-2">
				<c:if test="${i.writer==nickname}">
					<div class="reply_btns">
						<input type="button" value="수정" class="modify_btn">
						<input type="button" value="삭제" class="delete_btn">
					</div>
				</c:if>
					<div>
						좋아요
					</div>
				</div>	
			</div>
		</c:forEach>
<!-- 게시글 목록, 수정, 삭제 버튼---------------------------------------------------------- -->
			<input type="button" id="toList" value="목록으로">
			<c:if test="${nickname==dto.writer }">
				<input type="button" id="modify" value="수정하기">
				<input type="button" id="delete" value="삭제하기">
			</c:if>
		</div>
		</div>
	</div>
	<div class="row w-100 m-0" id="footer">
		<div class="col-12">Copyright by Phoenix since 2022 05 00</div>
	</div>
	<div ></div>

	<script>
	<!--  게시글 script-------------------------------------------------------------------- -->
		$("#toList").on("click",function(){
			location.href="/list.brd1?cpage=1";
		})
		$("#modify").on("click",function(){//수정하기
			location.href="/toModifyForm.brd1?seq=${dto.seq}";
		})
		$("#delete").on("click",function(){
			let result = confirm("정말 삭제하시겠습니까?")
			if(result){
				location.href="/delete.brd1?seq=${dto.seq}";
			}
		})
	<!-- 댓글 script-------------------------------------------------------------------- -->
		$("#reply").on("click",function(){		
// 			1. 제출 시 radio 체크여부 확인
			if(!$('input:radio[name="agree"]').is(":checked")){
				alert("'산다','만다' 중 선택해 주세요.");
				return false;
			}
// 			2. 댓글 공백 시 제출 불가
			if($("#contents_reply").val()==''){
				alert("댓글 내용을 입력해주세요.");
				return false;
			}
		})
		
		$(".modify_btn").on("click",function(){
			$(this).parent().parent().prev().children().eq(1).removeAttr('disabled');
		})
	</script>
</body>
</html>