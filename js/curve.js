window.onload = function() {
	var bg = document.getElementById("curve")
	linedata = {
		labels: ["杂七杂八", "集群", "C++", "深度学习", "算法"],//标签
		datas: [2, 1, 1, 6, 1],//数据
		xTitle: "分类",//x轴标题
		yTitle: "文章数量",//y轴标题
		ctxSets:{
			strokeColor:"#C0C0C0",//背景线颜色
			lineWidth:1,//线的宽度
			txtColor:"#000000",//绘制文本颜色
			txtFont:"12px microsoft yahei",//字体
			txtAlign:"center",//对齐方式
			txtBase:"middle",//基线
			lineColor:"blue",//折线颜色
			circleColor:"#FF0000"//折线上圆点颜色	
		}
	};
	setBg(bg,linedata);//绘制图标背景及折线
}