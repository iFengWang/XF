require('UIView,UIColor,UILabel');
defineClass('ViewController', {
    buildView: function() {
        var v = self.ORIGbuildView();
            
//        v.setBackgroundColor(UIColor.greenColor());
//        v.setFrame({x:100,y:50,width:150,height:150});
            
//        var l = UILabel.alloc().initWithFrame(v.frame());
//        l.setText('ok');
//        v.addSubview(l);
            
        return v;
    }
});
