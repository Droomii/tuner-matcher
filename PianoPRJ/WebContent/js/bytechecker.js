function checkBytes(el, limit){
	var b, i, c;
	var s = el.value;
	var last;
    for(b=i=0; c=s.charCodeAt(i);i++) {
    	if(s.charAt(i).match(/[<>]/)!=null){
    		b += 5;
    	}else if(s.charAt(i).match(/[\(\)']/)!=null){
    		b += 6;
    	}else if(s.charAt(i)=="\n"){
    		b += 12;
    	}else{
    		b+=c>>11?3:c>>7?2:1;
    	}
    	if(b > limit){
    		alert('글자수를 초과하였습니다.');
	    	el.value = el.value.substring(0, i);
	    	el.parentElement.querySelector('span').innerHTML = last;
	    	return
    	}
    	last = b;
    }
    el.parentElement.querySelector('span').innerHTML = b;
    
    return b
}