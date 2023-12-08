<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>경기도청 평가앱</title>
    <tiles:insertAttribute name="head" />
    <script type="text/javascript">
    	var __contextPath__ = '${pageContext.request.contextPath}';
    </script>
</head>
<body class="body-bg">
<main>
<tiles:insertAttribute name="content" />
</main>
</body>
</html>