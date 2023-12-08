<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${0 < modalPaging.totalCount}">
    <div class="page_wrap">
      <ul class="pagination">
          <li><a href="javascript:modalPageMove(${modalPaging.firstPageNo})" class="first">처음 페이지</a></li>
          <li><a href="javascript:modalPageMove(${modalPaging.prevPageNo})" class="arrow left"> &lt; </a></li>
           <c:forEach var="i" begin="${modalPaging.startPageNo}" end="${modalPaging.endPageNo}" step="1">
                <c:choose>
                    <c:when test="${i eq modalPaging.pageNo}">
           			  <li><a href="javascript:modalPageMove(${i})" class="active num">${i}</a></li>
                    </c:when>
                    <c:otherwise>
                      <li><a href="javascript:modalPageMove(${i})" class="num">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
          <li><a href="javascript:modalPageMove(${modalPaging.nextPageNo})" class="arrow right"> &gt; </a></li>
          <li><a href="javascript:modalPageMove(${modalPaging.finalPageNo})" class="last">마지막 페이지</a></li>
      </ul>
    </div>
</c:if>