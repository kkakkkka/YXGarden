<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% request.setCharacterEncoding("utf-8");
    int nowPage = (int)session.getAttribute("page");
    session.putValue("page", nowPage-1);
%>

<script>
    window.history.go(-1);
</script>