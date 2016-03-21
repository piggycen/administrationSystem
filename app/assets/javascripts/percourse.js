var info = [];
function getPercourse(){
	$.ajax({
		url: '/api/v1/student/percourse?user=' + $.getParam("user"),
		// data:{
		// 	user: $.getParam("user")
		// },
		type: 'get',
		cache: false,
		dataType: 'json',
		success: function(data){
			if (data && data.status == 0){
				info = new Array();
				info = data.data;
			}
		showCourse();
	}
	});
}
function showCourse(){
	for(var i=0, len=(info.length); i<len; i++){
		var cname = info[i]['cname'];
		var tname = info[i]['tname'];
		var teachplace = info[i]['teachplace'];
		for(var j=0, length=info[i]['teachtime'].length-1; j<length; j++){
			if (info[i]['teachtime'][0] == '0'){
				var week = '单周';
			}else if(info[i]['teachtime'][0] == '1'){
				var week = '双周';
			}else{
				var week = '';
			}
			var text = cname + '&nbsp;' + tname + '<br/>' + teachplace + '&nbsp;' + week + '第' + (parseInt(info[i]['teachtime'][3])+1) + '~' + (parseInt(info[i]['teachtime'][4])+1) + '周';
			$id('time-' + info[i]['teachtime'][1] + '-' + info[i]['teachtime'][2]).innerHTML = text;
		}
	}
}
getPercourse();
