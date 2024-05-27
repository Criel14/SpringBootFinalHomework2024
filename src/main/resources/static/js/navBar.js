// 进入不同页面，对应的链接会变粉
document.addEventListener("DOMContentLoaded", function () {
    var path = window.location.pathname;
    var pathToId = {
        "/index": "index-link",
        "/freeMovie": "freeMovie-link",
        "/vipMovie": "vipMovie-link",
        "/rank": "rank-link",
    };
    var currentId = pathToId[path];
    if (currentId) {
        document.getElementById(currentId).classList.add("active");
    }
});
