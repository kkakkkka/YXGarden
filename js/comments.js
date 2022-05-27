const express = require('express');
const app = express();
const fs = require('fs');
const sd = require('silly-datetime');
const readline = require('readline');

app.use(express.static('../medias'));

let oldHtmlContent = fs.readFileSync('../page/comment.html').toString(); //读取comment.html文档

app.get('../', function(req, res) {
    res.send(oldHtmlContent);
    fs.writeFileSync('records.txt', ''); //初始化txt为空白
});

app.get('./comment', function(req, res) {

    writeRecord(req.query.comment, sd.format(new Date(), 'YYYY-MM-DD HH:mm')); //记录评论与时间

    //加载评论
    let newHtmlContent = '';
    let r = /\d{4}-\d{2}-\d{2} \d{2}:\d{2}/ //匹配日期
    let floorNumber = 2;
    let comment = '';
    //使用readline逐行读取文件
    const r1 = readline.createInterface({
        input: fs.createReadStream('../records.txt')
    })
    r1.on('line', (line) => {
        if (r.test(line)) {
            //新评论的HTML代码
            newHtmlContent =
                `<div class="comment">
                <span class="comment-avatar">
                <img src="avatar1.jpg" alt="avatar">
                </span>
                <div class="comment-content">
                    <p class="comment-content-name">EdmundDZhang</p>
                    <p class="comment-content-article">${comment}</p>
                    <p class="comment-content-footer">
                        <span class="comment-content-footer-id">#${++floorNumber}</span>
                        <span class="comment-content-footer-device">来自中山大学</span>
                        <span class="comment-content-footer-timestamp">${line}</span>
                    </p>
                </div>
                <div class="comment-cls"></div>
                </div>` + newHtmlContent;
            comment = '';
        } else {
            comment += line;
        }
    }).on('close', () => {
        res.send(oldHtmlContent.replace('<div class="comment-list" id="commentList">', '<div class="comment-list" id="commentList">\n' + newHtmlContent));
    })
})

function writeRecord(comment, datetime) {
    fs.writeFileSync('../records.txt', `${comment}\n${datetime}\n`, { flag: 'a' });
}

app.listen(5501, '127.0.0.1');