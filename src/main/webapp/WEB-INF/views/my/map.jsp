<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}" scope="application"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

    <link rel="stylesheet" href="${contextPath}/resources/css/my/map.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
</head>

<body>


<div id="map" style="width: 100%; text-align: center;">
    <div id="menu-warp">
        <div class="upArrow">
            <i class="fas fa-angle-up"></i>
        </div>
        <div class="option" >
            내 위치로 이동 <i class="fas fa-location-arrow" style="margin-left: 10px; color:#A59999;"></i>
        </div>
        <hr>
        <ul id="placesList">
            <li class="item">
                <div class="info">

                    <div class="img" >
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE6---2DCrVkPCe2Bao73LEY-THyen07CuEg&usqp=CAU">
                    </div>

                    <div class="container">
                        <h3>류관현 <span style="color: chocolate;">마스터 상담사</span></h3>
                        <h5>
                            온라인상담 |
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAAtpJREFUSA21l89PE1EQx2e2m0DVCwkeUBrTpJbUBLQ/Aog0mGg4cUESJF5MvELiBf8K8eDBK4kXEw8e4QQnEdT0h72URGqMAS89G4ilZfw+krfd3exu2zW85OXNzJuZz5u3b9+2RCGb7N1MFYvFVMhwMsIG0tnZI8SqHqqFBwsviMhCKCqCQoHly0gc0DTi05VKJR4GHgpMjaa1xaenp5bcywLCgZmtLWabfKFg2Rm5RiSTNshkqVSCrbfWe8XSmhch1hg8a0af13q3Y+9gFq9n6mULXENPYCkkB0loxp0RFc8UCoVBtz1IN2U3kSaOXApysub+th4KUcTS20IEh2y5XC5vtU3+EnyPWV191JJ3WPUdf1fvmVL0vfdEsPUbwE8MvnuwTwN9E8zGGjM28oIaYIK+Fo1GJ7LZ7L51OhVPdpMPcAe/RfXXu+F3WzGAv9GfZjKZbZ3Xcbh46vs2GX1jcPqgHf53VLn6+/vH7FCV01GxHSIfE8+gvxaSK3a7XQ6qGMA/6M8BXLfHaNlRsTaqkfO1dYpImom/2u1dyiom7QdVOXwr1gCR+ybtHFVQ+S1t06NXxaiyCuBtjE3t5zX6Vmw5l48GICctvYOAg5nE+6xiAltn8DE++CRmYBbnpPK1vl7OqbbWGSyy1HbvTkLVHWMCwVJIDRFL3guHw7GF5+h3ReZxdw95xWlbIJhOmov4BDp8AGsAukrTtVkcolkkWlU2nVCNqFjFLNptbtmR1D2Jah/bbXi1qiTGOOd/vAJMXYGSy+WUPI5edfgyO2Ltc0r2fZ3kU+oGSeOn/ugj8Rsyrr7gqb0TdxKlHx4eRuv1+ktUu6x0tSj0OHbll9Ldzb9iOd9mxFKdDWOOp2srflCVNBaLneDyX4E4h6A6FqB+mfhudwBYlgDdJL48yvcONtwr9tOx9RumaY5ifhPgjqfbkUc+J4ZxV59vmWOiRwV/cZbxu3vYK+wfkSzoDsHGCfIAAAAASUVORK5CYII="
                                 width="15" height="14" alt="작은 별점 1점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAAqNJREFUSA2tVk1rE0EYzrYbSKQXRYIfCaUiggaJJiH+AIsnL1poRQ+CBy8VvOivUA8evHgoeNCbRz3pH5B8HlIvYpG0VULxJBqMZn2eZWc7O5nZ7I5deJl33vf5yMzsTpvJWD6tVussw5KembMlgnc9CCsJa2PP81YYVq4gOTbEXq+3NB6PP5ObzWZPVSqVrbQ6ViuGKbfZf+Rc1JKMVsaO44RbLOdJDAUm9Va32+0TONtthM+FsYcoVqvVXSGaZEy9YhheE6Y0YM5aEjMZk9oY5PB8JSFdTWpPp6m2utlsHoXEN8S8IvUX82P1en1PqRunbrfbvYitOmRESI3JZLIMrGpKxDzOeb3T6byT4MYU2J8Orz2IvQLqghF5sI0ujG/O1Wq1j/l8/hImjxHewXrsq1GbHvSiZ+SM8alcxupfIE7uU/4/g+EO4jY+ufdCLWLMYr/fPzIajZ7DPLwkBNhmhOHrXC53t1wuf5f5U8aiidXfgflTxIKopRlh+ANxH6vc0PGMxgTjxTsN45dIGzpyTO0DTG/hLD+ZMLHGJMHYxep7GM+ZROQ6DDexygrGP3JdzWfeXPg2D8P0jEo0zYklx9QX9ZnGAPIlcwUhwUjszBdzpjFWcCOBWQSShBN7xribj+Os+Cdw6gei7l+P6C1HXDFBb4J6EXf3V7Un5lOCohGMq6opRH+j9wAv0BUG86AWUgPOaljQJLHGEFyTOZhvIhpYyROMvAK9IG+wp2AjXLnH3LjV+IQW8cu3ED4Gws8KhcLDUqn0SxXhfDAY5IfD4SPg1zkPftgSduUL5+pjXDEEuM3gO0OQruIyuGcypSh7xBBLDrnUYE/3xBnzbX7ruu55bOcbHVlXI5YccmGc7ovA/81FXJf+lunEk9aoQS0d/h/pAwlu3rYpxwAAAABJRU5ErkJggg=="
                                 width="15" height="14" alt="작은 별점 0점 이미지">
                            <span>(246)</span>
                        </h5>
                        <div>다치기 쉬운 유리같은 사람의 마음</div>
                        <h5 style="float: right;">상담사 가격 : 49,800 </h5>
                    </div>

                </div>
            </li>
            <li class="item">
                <div class="info">

                    <div class="img" >
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE6---2DCrVkPCe2Bao73LEY-THyen07CuEg&usqp=CAU">
                    </div>

                    <div class="container">
                        <h3>조용진 <span style="color: chocolate;">전문 상담사</span></h3>
                        <h5>
                            온라인상담 |
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <span>(7246)</span>
                        </h5>
                        <div>포근한 나무가 되어드리고 싶습니다</div>
                        <h5 style="float: right;">상담사 가격 : 999,800 </h5>
                    </div>

                </div>
            </li>
            <li class="item">
                <div class="info">

                    <div class="img" >
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE6---2DCrVkPCe2Bao73LEY-THyen07CuEg&usqp=CAU">
                    </div>

                    <div class="container">
                        <h3>서승준 <span style="color: chocolate;">전문 상담사</span></h3>
                        <h5>
                            온라인상담 |
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAArVJREFUSA2tVs1rE0EUf28TWr8uBQU/AqLGhAh+QWhrTECwePJiC1r0IHit4MU/Qw8evAoe9OZRTwqCNVEpaC+Wpqle4gfiURobdvN8b9JdZ7a7k822C8u++b3fx87sZFqAlBc1jpfkTikHJ60Qer1pdac0SB9MOANyp7wwjY7eF49Q1/0iWhzJHsWJ5a/D+qSbcdedDoL0OgAHF+mCUVtivR6cFzCGXmqaLx4EcNtEoLSIQADZHFaXvweuCYrhZ0zeFT9U/FXNWIIsgzJ8MNL/7+tbRWF+L+Y51FLTQmEvdLyfvLYZ3Y9NPNiZ2Y/l5m8dt9VZqufPAmZ22UhBb92bCodKTzBc781Ro/gy4NoK8tZQHXsePSWiMzbudvUQ8RO/5nUHz60swdjoBKJzr79DtyvC9BFvyVBZnGl8Y6oXLvL5+5hnf8iUbW3Es/wGjnMTK81XvpOxq1XDGT3FxGc+YatP5SWeWqh4GjPWQ+hN/haPHxDQHh1PWiPgH+bewVrrUZQmNljIVD+WBw+fcPh4lDgO49APkKEbWFltxXPiOhs40YUszLcXOfzEAKpqc+hnqOZOI752bXzjG0cSP7bHGC9E9qLBAvQ10d0NdHDwGs7wbLNWF62puKzRoMhycDDRbKTSBibQ2DfXQukA/O3Kn8BNL8hCdTzycTkVfgc+LHqwYySH5aUf4Z4/3mToN9Sz414Nh/Lvssuhd6HauiS31ILpOqVhrY6Fa3sw0jVdoHYsOeNYW73PYXwE8s01CCa7Wb9CWr0ldWwwvS0d5l/ypC/gkIeQ2VfGWnPRx/ynwqQnnOCiyb5HABhFbDCQWmb2gl/oOJex2rqNlUbHUGsD6SmOcFnT/88kfrktwTTLBi8Ad5/E8yvPtQxrqbiiEW2C3W2Y0bt8js/qOQNMMRAP8YqS/gMbzegG1X8tjgAAAABJRU5ErkJggg=="
                                 width="14" height="14" alt="작은 별점 2점 이미지">
                            <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAAcCAYAAAB2+A+pAAAAAXNSR0IArs4c6QAAAqNJREFUSA2tVk1rE0EYzrYbSKQXRYIfCaUiggaJJiH+AIsnL1poRQ+CBy8VvOivUA8evHgoeNCbRz3pH5B8HlIvYpG0VULxJBqMZn2eZWc7O5nZ7I5deJl33vf5yMzsTpvJWD6tVussw5KembMlgnc9CCsJa2PP81YYVq4gOTbEXq+3NB6PP5ObzWZPVSqVrbQ6ViuGKbfZf+Rc1JKMVsaO44RbLOdJDAUm9Va32+0TONtthM+FsYcoVqvVXSGaZEy9YhheE6Y0YM5aEjMZk9oY5PB8JSFdTWpPp6m2utlsHoXEN8S8IvUX82P1en1PqRunbrfbvYitOmRESI3JZLIMrGpKxDzOeb3T6byT4MYU2J8Orz2IvQLqghF5sI0ujG/O1Wq1j/l8/hImjxHewXrsq1GbHvSiZ+SM8alcxupfIE7uU/4/g+EO4jY+ufdCLWLMYr/fPzIajZ7DPLwkBNhmhOHrXC53t1wuf5f5U8aiidXfgflTxIKopRlh+ANxH6vc0PGMxgTjxTsN45dIGzpyTO0DTG/hLD+ZMLHGJMHYxep7GM+ZROQ6DDexygrGP3JdzWfeXPg2D8P0jEo0zYklx9QX9ZnGAPIlcwUhwUjszBdzpjFWcCOBWQSShBN7xribj+Os+Cdw6gei7l+P6C1HXDFBb4J6EXf3V7Un5lOCohGMq6opRH+j9wAv0BUG86AWUgPOaljQJLHGEFyTOZhvIhpYyROMvAK9IG+wp2AjXLnH3LjV+IQW8cu3ED4Gws8KhcLDUqn0SxXhfDAY5IfD4SPg1zkPftgSduUL5+pjXDEEuM3gO0OQruIyuGcypSh7xBBLDrnUYE/3xBnzbX7ruu55bOcbHVlXI5YccmGc7ovA/81FXJf+lunEk9aoQS0d/h/pAwlu3rYpxwAAAABJRU5ErkJggg=="
                                 width="15" height="14" alt="작은 별점 0점 이미지">
                            <span>(3236)</span>
                        </h5>
                        <div>다치기 쉬운 유리같은 사람의 마음</div>
                        <h5 style="float: right;">상담사 가격 : 1,999,800 </h5>
                    </div>

                </div>
            </li>
            <li class="item">
                <div class="map-info">

                    <div class="img-img" >
                        <img src="${contextPath}/resources/images/my/premium-icon-hospital-3606564.png">
                        <!-- <div style="font-size: 28px; text-align: center; line-height: 60px;">1</div> -->
                    </div>

                    <div class="container" >
                        <h3>루비병원</h3>
                        <div style="margin-bottom: 10px;">심리 상담 센터</div>
                        <div>219m(distance) | 서울 중구 명동9길 21 4층</div>
                        <div style="margin-bottom: 10px;">02-000-0000</div>
                    </div>

                </div>
            </li>
            <li class="item">
                <div class="map-info">

                    <div class="img-img" >
                        <img src="${contextPath}/resources/images/my/premium-icon-hospital-3606564.png">
                    </div>

                    <div class="container" >
                        <h3 >나사랑병원</h3>
                        <div>심리 상담 센터</div>
                        <div>428m(distance) | 서울 중구 충무로1가</div>
                        <div>02-000-0000</div>
                    </div>

                </div>
            </li>
            <li class="item">
                <div class="map-info">

                    <div class="img-img">
                        <img src="${contextPath}/resources/images/my/premium-icon-hospital-3606564.png">
                    </div>

                    <div class="container">
                        <h3 >노원구 청소년상담복지센터</h3>
                        <div >심리 상담 센터</div>
                        <div>14km(distance) | 서울특별시 노원구 덕릉로 777</div>
                        <div>02-000-0000</div>
                    </div>

                </div>
            </li>


        </ul>

    </div>

    <!-- 상세 뷰 -->
    <div id="menu-view" style="visibility: hidden;">

        <div class="option-view"></div>
        <div id="quit" style="float: right;">X</div>
        <hr>

        <div class="location-img">
            <i class="fas fa-map-marker-alt"></i>
            <span class="location-span">병원 위치</span>
        </div>

        <div class="tel-number" >
            <i class="fas fa-phone-alt"></i>
            <span class="location-tel">병원 번호</span>
        </div>

        <div class="internet">
            <i class="fab fa-internet-explorer"></i>
            <a href="#"><span class="location-internet">주소</span></a>
        </div>

        <!-- /link/to/이름,위도,경도	https://map.kakao.com/link/to/카카오판교오피스,37.402056,127.108212 -->
        <div onclick="window.open(loadSearch());" style="position: absolute; right: 0; top: 45px; border: 1px solid #ccc;
                width: 70px; min-width: 70px; text-align: center; height: 30px; line-height: 28px;
                background-color: rgba(84, 127, 207, 0.452); cursor: pointer;">
            길찾기
        </div>

        <div class="AD" style="text-align: center; border: 1px solid black; height: 50px; line-height: 48px;">
            광고
        </div>

        <!-- hr 태그 대신 -->
        <div style="border-top: 1px solid black;"></div>


        <div class="pro-information">
            <div class="talk-b-info" style="margin-bottom: 20px;">
                <h3><b>상담관련 정보</b></h3>
            </div>
            <div>
                <b>상담 : </b>
                <span class="talk-b-span1">아동상담</span>
            </div>
            <div>
                <b>심리검사 : </b>
                <span class="talk-b-span2">발달검사, 진로/적성검사</span>
            </div>
            <div style="color: rgb(114, 114, 114);">· 모든 정보는 변경이 있을 수 있습니다. 반드시 전화 확인 후 방문해주세요.</div>
        </div>

    </div>
</div>

<script>

    const contextP = "${contextPath}";

</script>

<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f9cc932f2cb179a77079e2c667dab98a&libraries=services"></script> -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f9cc932f2cb179a77079e2c667dab98a&libraries=services,clusterer,drawing"></script>
<script>
    const contextPath = "${contextPath}";
</script>
<script src="${contextPath}/resources/js/my/map.js"></script>
</body>


