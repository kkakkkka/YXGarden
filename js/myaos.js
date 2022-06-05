cnt = 0;
function addEvent(obj, type, fn) {
    if (obj.attachEvent) { //ie
        obj.attachEvent('on' + type, function() {
            fn.call(obj);
        })
    } else {
        obj.addEventListener(type, fn, false);
    }
}


function setAni(i) {
    if (isAni[i]) return;
    isAni[i] = true;
    var div = aosDivs[i];
    div.style.animation = "";
    div.style.opacity = 0;
    var delay = 100; //ms
    var duration = 800; //ms
    setTimeout(function() {
        div.style.opacity = 1;
        div.style.animation = "myaosmove " + duration + "ms 1";
    }, delay);
    setTimeout(function() {
        isAni[i] = false;
    }, delay + duration);
}

function windowHeight() { //获取页面浏览器客户区的高度
    return (document.compatMode == "CSS1Compat") ? document.documentElement.clientHeight :
        document.body.clientHeight;
}

function show() {
    for (var i = 0; i < cnt; i++) {
        var div = aosDivs[i];
        var rect = div.getBoundingClientRect();
        var clientHeight = windowHeight();
        var top = rect.top;
        if (isAni[i]) continue;
        if ((clientHeight - top) < 0) {
            div.style.opacity = 0;
        }
        if ((clientHeight - top) < clientHeight / 10) {
            judge[i] = false;
        } else {
            if (!judge[i]) {
                setAni(i);
            }
            judge[i] = true;
        }
    };
};

addEvent(window, "scroll", show);

addEvent(window, "load", function() {
    aosDivs = document.getElementsByClassName("myaos");
    cnt = aosDivs.length;
    if (!cnt) return false;
    judge = [];
    isAni = [];
    for (var i = 0; i < cnt; i++) {
        judge[i] = false;
        isAni[i] = false;
    }
    show();
});