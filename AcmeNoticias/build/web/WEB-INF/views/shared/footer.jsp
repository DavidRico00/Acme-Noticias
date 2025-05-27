<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${sessionScope.language != null ? sessionScope.language : 'es'}" />
<fmt:setBundle basename="resources.messages" />

<footer class="footer text-center">
    <p>&copy; <fmt:message key="footer.texto"/></p>
</footer>