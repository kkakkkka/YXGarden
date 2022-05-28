var floorNumber = 2;

function load() {
    var old = localStorage.getItem(localStorage.length - 1);
    var contain = document.getElementsByClassName("comment-list")[0];
    if (localStorage.length > 0)
        contain.innerHTML = old;
}

window.onload = load;

function getCurrentTime() {
    var date = new Date();
    var year = date.getFullYear();
    var month = repair(date.getMonth() + 1);
    var day = repair(date.getDate());
    var hour = repair(date.getHours());
    var minute = repair(date.getMinutes());
    var second = repair(date.getSeconds());

    var curTime = year + "-" + month + "-" + day +
        " " + hour + ":" + minute + ":" + second;
    return curTime;
}

function repair(i) {
    if (i >= 0 && i <= 9)
        return "0" + i;
    else
        return i;
}

function addComment() {
    var comment = document.getElementsByClassName("comment-send-input")[0].value;
    var time = getCurrentTime();
    var newHtmlContent =
        `<div class="comment">
        <span class="comment-avatar">
        <img src="../medias/user1.jpg" alt="avatar">
        </span>
        <div class="comment-content">
            <p class="comment-content-name">hhy${localStorage.length}</p>
            <p class="comment-content-article">${comment}</p>
            <p class="comment-content-footer">
                <span class="comment-content-footer-id">#${localStorage.length+3}</span>
                <span class="comment-content-footer-device">来自中山大学</span>
                <span class="comment-content-footer-timestamp">${time}</span>
            </p>
        </div>
        <div class="comment-cls"></div>
        </div>`;

    var contain = document.getElementsByClassName("comment-list")[0];
    var old = localStorage.getItem(localStorage.length - 1);
    if (localStorage.length <= 0) {
        old = document.getElementsByClassName("comment-list")[0].innerHTML;
    }
    contain.innerHTML = newHtmlContent + old;
    localStorage.setItem(localStorage.length, contain.innerHTML);
    console.log(localStorage);
    return false;
}