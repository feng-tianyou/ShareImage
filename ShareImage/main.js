require("NSMutableArray, NSString, NSString");
require("testModel");


require("NSMutableArray, NSString, NSString");

defineClass("DTestViewController", {
            baseViewControllerDidClickNavigationBtn_isLeft: function(navBtn, isLeft) {
            if (!isLeft) {
            console.log("DTestViewController baseViewControllerDidClickNavigationBtn_isLeft");
            self.localShowSuccess("恭喜测试成功");
            return;
            }
            self.navigationController().popViewControllerAnimated(YES);
            },
            
            setupDatas: function() {
            console.log("DTestViewController setupDatas");
            var arr = NSMutableArray.array();
            for (var i = 0; i < 20; i++) {
            var model = testModel.alloc().init();
            model.setName(NSString.stringWithFormat("名字---%@", i));
            model.setProject("项目");
            model.setDate(NSString.stringWithFormat("2013/1/%@", i));
            if (i % 2 == 0) {
            model.setContent("这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据这是JSPatch测试的数据");
            } else {
            model.setContent("具体查看修改的数据，请查看DTestViewController，修改补丁数据请在main.js文件中修改");
            }
            model.setIcon("http://daisuke.cn/uploads/avatar.png");
            arr.addObject(model);
            }
            self.setPhotos(arr.copy());
            }
            }, {});
