window.onload = function() {
	var len = 5;
	//可以获取随机颜色
	colors = ["#00868B", "#8B658B", "#FFA07A", "#1E90FF", "#B452CD", "#4876FF", "#CDBE70", "#EEB422", "#00CD00", "#FF3030", "#EE6AA7"]
	for (var i=colors.length; i<len; ++i) {
		let r = Math.floor(Math.random() * 256);
		let g = Math.floor(Math.random() * 256);
		let b = Math.floor(Math.random() * 256);
		let rgb = `rgb(${r},${g},${b})`;
		colors.push(rgb);
	}
	var pie = document.getElementById("pie"),
	datasets = {
		colors: colors.slice(0, len), //颜色
		labels: ["杂七杂八", "集群", "C++", "深度学习", "算法"],//x轴的标题
		values: [2, 1, 1, 6, 1], //值
		x: 125, //圆心x坐标
		y: 125, //圆心y坐标
		radius: 100 //半径
	};
	pieChart(pie, datasets); //画饼状图
}