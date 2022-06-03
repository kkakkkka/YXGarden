//求和，计算百分比（画饼图时需要）
function sumFunc(data) {
		var sum = 0;
		for (var i = 0, len = data.length; i < len; i++) {
			sum += data[i];
		}
		return sum;
	}
/*饼图
 * elem:要操作的画布元素
 * data:所需格式的数据*/
function pieChart(elem, data) {
	if (elem.getContext) {
		var ctx = elem.getContext("2d"),
			vdata = data.values, //绘图数据
			sum = sumFunc(vdata), //对绘图数据求和，用于计算百分比
			startangle = 0, //绘制扇形的开始角度
			labels = data.labels, //绘图的对应文字
			x = data.x, //圆心x坐标
			y = data.y, //圆心y坐标
			rad = data.radius, //圆半径
			x1 = x + rad + 30, //绘制右侧文字和标注的x坐标
			y1 = y - rad, //绘制右侧文字和标注的y坐标
			endangle; //绘制扇形的结束角度
		for (var i = 0, len = vdata.length; i < len; i++) {
			//绘制饼图
			//计算下一次绘制扇形的结束角度，即根据绘制数据占有总数据和的比例求的弧度
			var percent = vdata[i] / sum;
			endangle = startangle + Math.PI * 2 * (percent);
			ctx.beginPath(); //开始绘制新路径
			ctx.fillStyle = data.colors[i]; //绘制颜色
			ctx.moveTo(x, y); //移动到圆心(注：画饼图一定要回到圆心，不然会有问题)
			ctx.arc(x, y, rad, startangle, endangle, false); //画扇形
			//绘制右侧文字和标注
			ctx.moveTo(x1, y1); //移动到绘制文字和标注的位置
			ctx.fillRect(x1, y1, 30, 14); //绘制矩形表示比列图
			//计算四舍五入后的扇形每份的百分比
			var perc = (percent * 100).toFixed(2) + "%"; //tofixed()自动四舍五入返回指定小数位数的字符串
			//设置绘制文字的属性
			ctx.font = "bold 12px microsoft yahei";
			ctx.txtalgin = "center";
			ctx.textBaseline = "top";
			//绘制文字
			ctx.fillText(labels[i] + ":" + perc, x1 + 35, y1);
			ctx.fill(); //指定颜色填充以上绘制
			startangle = endangle; //下一次绘制扇形的开始角度
			y1 += 20; //下一次绘制文字和标注的y坐标
		}
	}
}
function curveChart() {
		var elem = document.getElementById("curve");
		if (elem.getContext) {
			var ctx = elem.getContext("2d");
			//			ctx.lineWidth = 2;
			ctx.lineCap = "square";
			ctx.beginPath();
			ctx.moveTo(100, 70);
			ctx.bezierCurveTo(120, 150, 150, 150, 200, 60); //三次贝赛尔曲线
			ctx.moveTo(40, 100);
			ctx.quadraticCurveTo(60, 60, 100, 70); //二次贝塞尔曲线
			ctx.moveTo(200, 60);
			ctx.arcTo(240, 40, 300, 50, 50); //绘制弧线
			ctx.stroke();

		}
	}
/*	绘制背景
 * elem:要操作的元素
 * data:所需格式的数据*/
function setBg(elem, data) {
	if (elem.getContext) {
		var ctx = elem.getContext("2d"),//获取元素上下文
			startX = 40,//左上角开始绘制的x坐标
			startY = 40,//左上角开始绘制的y坐标
			labels = data.labels,//对应数据的标签，即列数
			cols = labels.length,//数据个数
			datas = data.datas,//数据
			gWidth = elem.width - 80,//背景总宽度,elem.width为画布宽度
			gHeight = elem.height - 80,//背景总长度
			pgWidth = gWidth / cols,//背景每个格的宽度
			rows = 10,//背景表格行数
			pgHeight = gHeight / rows;//背景表格高度


		//绘制背景
		ctx.beginPath(); //开始绘制新路径
		ctx.strokeStyle = data.ctxSets.strokeColor;//描边颜色
		ctx.lineWidth = data.ctxSets.lineWidth;//描边线条宽度
		//绘制横线
		for (var i = 0; i < rows; i++) {
			var pY = startX + pgHeight * i;
			ctx.moveTo(startX, pY); //移动到绘制的起点
			ctx.lineTo(gWidth + startX, pY);
		}
		//最后一根横线
		var pY1 = startY + pgHeight * rows;
		ctx.moveTo(startX, pY1); //移动到绘制的起点
		ctx.lineTo(gWidth + startX + 20, pY1);
		//绘制竖线
		//第一根竖线
		ctx.moveTo(startX, startY - 20); //移动到绘制的起点
		ctx.lineTo(startX, gHeight + startY + 10);
		for (var i = 1; i < cols + 1; i++) {
			var pX = startX + pgWidth * i;
			ctx.moveTo(pX, startY); //移动到绘制的起点
			ctx.lineTo(pX, gHeight + startY + 10);
		}

		ctx.stroke();//把图形绘制到画布上
		//绘制文字
		ctx.fillStyle = data.ctxSets.txtColor;//填充颜色
		ctx.font = data.ctxSets.txtFont;//文本字体
		ctx.textAlign = data.ctxSets.txtAlign;//文本对齐方式
		ctx.textBaseline = data.ctxSets.txtBase;//文本基线
		//绘制横轴文字
		for (var i = 0; i < cols; i++) {
			var px = startX + pgWidth / 2 + pgWidth * i;
			ctx.fillText(labels[i], px, startY + gHeight + 10);
		}
		//绘制竖轴文字
		//判断最大值是否大于行高，确定每行的数值
		var maxValue = 0,
			newValues = new Array(),
			j = 0;
		for (var i = 0; i < cols; i++) {
			if (datas[i] > maxValue) {
				maxValue = datas[i];
			}
		}
		//重新计算每隔数据值及转换值
		if (maxValue > gHeight) {
			pgValues = maxValue / rows;
			for (var i = 0; i < cols; i++) {
				newValues[i] = datas[i] * gHeight / maxValue;
			}
		} else {
			pgValues = pgHeight;
			newValues = datas;
		}
		//绘制竖轴文字
		for (var i = rows; i >= 0; i--) {
			ctx.fillText(pgValues * i, 20, startY + pgHeight * j);
			j++;
		}

		//绘制标题
		//x轴标题	
		ctx.fillText(data.xTitle, gWidth + startX + 15, gHeight + startY + 10);
		//y轴标题
		ctx.fillText(data.yTitle, startX + 25, startY - 10);
		
		
		//画图
		//绘制折线
		ctx.strokeStyle = data.ctxSets.lineColor;;
		ctx.beginPath();
		var pointX = pgWidth / 2 + startX,
			pointY = startY + gHeight - newValues[0];
		ctx.moveTo(pointX, pointY);
		for (var i = 1; i < cols; i++) {
			pointX += pgWidth;
			pointY = startY + gHeight - newValues[i];
			ctx.lineTo(pointX, pointY);
		}
		ctx.stroke();
		//绘制坐标圆形
		ctx.beginPath();
		ctx.fillStyle = data.ctxSets.circleColor;; //圆点的颜色
		for (var i = 0; i < cols; i++) {
			var circleX = pgWidth / 2 + startX + pgWidth * i,
				circleY = startY + gHeight - newValues[i];
			ctx.moveTo(circleX, circleY); //假如不每次绘制之前确定开始绘制新路径，可以每次绘制之前移动到新的圆心
			ctx.arc(circleX, circleY, 4, 0, Math.PI * 2, false);
		}
		ctx.fill();
		//绘制坐标圆形对应的值
		ctx.beginPath();
		ctx.fillStyle = data.ctxSets.txtColor; //文本颜色
		for (var i = 0; i < cols; i++) {
			var circleX = pgWidth / 2 + startX + pgWidth * i,
				circleY = startY + gHeight - newValues[i];
			ctx.fillText(datas[i], circleX, circleY - 10);
		}
		ctx.fill();

	}

}