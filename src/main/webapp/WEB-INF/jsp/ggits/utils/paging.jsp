<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${0 < paging.totalCount}">
    <div class="page_wrap">
      <ul class="pagination">
          <li><a href="javascript:pageMove(${paging.firstPageNo})" class="first">&lt;&lt;</a></li>
          <li><a href="javascript:pageMove(${paging.prevPageNo})" class="arrow-left">&lt;</a></li>
           <c:forEach var="i" begin="${paging.startPageNo}" end="${paging.endPageNo}" step="1">
                <c:choose>
                    <c:when test="${i eq paging.pageNo}">
           			  <li><a href="javascript:pageMove(${i})" class="active num">${i}</a></li>
                    </c:when>
                    <c:otherwise>
                      <li><a href="javascript:pageMove(${i})" class="num">${i}</a></li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
          <li><a href="javascript:pageMove(${paging.nextPageNo})" class="arrow-right">&gt;</a></li>
          <li><a href="javascript:pageMove(${paging.finalPageNo})" class="last">&gt;&gt;</a></li>
      </ul>
    </div>
</c:if>