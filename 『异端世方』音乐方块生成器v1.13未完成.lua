--[[        
       『异端世方』音乐方块生成器v1.13
音乐玩家一天7张图的秘密 告别手撸 拯救肝脏 让你的音乐创作更加高效且准确
开发者模式下 新建一个脚本 将此文档粘贴 转换玩法地图即可使用 
若要保留玩法模式下的创作 请开启玩法模式退出不重置地图
1.5以上版本 联机房间中可以正常使用 玩家数据分别存储 互不干扰
作者：异端 世方府 欧阳闻奕-528278703
异端 世方府工作室版权所有
本项目托管在Github: OWALabuy/MiniWorldMusicTool
请关注异端老大轨心夕（杀手没有恨） 迷你号139246171

        Music Block Generator v1.13 by Heresy Shifang Studio

Unlock the secret of creating seven maps a day for music players, bid farewell to manual block placement, save your liver, and make your music creation more efficient and accurate.

In Developer Mode, create a new script and paste this document to convert your gameplay map for use. 

To preserve your creative mode gameplay, please enable Creative Mode and exit without resetting the map.

For versions 1.5 and above, it can be used normally in online rooms, with player data stored separately and without interference.

Author: Heresy Shifang Studio - @OWALabuy-528278703

All rights reserved by Heresy Shifang Studio.

This project is hosted on Github: OWALabuy/MiniWorldMusicTool
--]]


---------------------- 字符串常量(语言组) ----------------------
-- copy list 文案列表
local CL = {
    tip = { --提示
        copy = {
            copySuccessfully = {
                "#cFFE1E1复制区域内所有音乐方块成功，区域起点(%d,%d,%d)",
                "#cFFE1E1Copy all music blocks in the area successfully, the starting position of the area is (%d,%d,%d)"
            },
            copySuccessfully2 = {
                "#cFFE1E1使用极寒域法杖可粘贴方块。",
                "#cFFE1E1Use the Frostbite staff to paste the blocks."
            },
            pasteSuc = {
                "#cCDF0EA粘贴音乐方块成功 起点(%d,%d,%d)",
                "#cCDF0EAPaste the music blocks successfully. Starting pos (%d,%d,%d)",
            },
            changePasWay = {
                "#c8bf6ab已将粘贴的方式改为#W%d",
                "#c8bf6abThe pasting method has been changed to #W%d",
            },
            startUndo = {
                "#c8bf6ab开始撤销",
                "#c8bf6abStart Undo",
            },
            startPaste = {
                "#c8bf6ab开始粘贴",
                "#c8bf6abStart Paste"
            },
            strPos = {
                "#c8EC3B0已锚定区域起点(%d,%d,%d)",
                "#c8EC3B0The starting pos of the area is(%d,%d,%d)",
            },
            endPos = {
                "#c8EC3B0已锚定区域终点(%d,%d,%d)",
                "#c8EC3B0The end pos of the area is(%d,%d,%d)"
            },
            canStrPos = {
                "#c8bf6ab取消了区域起点",
                "#c8bf6abRegion start removed",
            },
            canEndPos = {
                "#c8bf6ab取消了区域终点",
                "#c8bf6abRegion end removed",
            },
            tip2 = {
                "#c9ED5C5选择其他快捷栏清除所有锚定的点",
                "#c9ED5C5Select other shortcut bars to clear all anchored points",
            },
            tip3 = {
                "#cBCEAD5再次使用雷电法杖可以复制",
                "#cBCEAD5Use the Lightning Staff again to duplicate",
            },
            tip4 = {
                "#cDEF5E5再次选择雷电法杖快捷栏可取消区域的终结点",
                "#cDEF5E5Select the Lightning Staff shortcut bar again to cancel the end point of the area",
            },
            strEntData = {
                "#cBCCEF8开始录入数据，向量(%d,%d,%d)，方向(%d,%d,%d)",
                "#cBCCEF8Start data entry, vector(%d,%d,%d), direction (%d,%d,%d)",
            },
            pasteTip = {
                "#c36B5B0使用极寒域法杖可以您的位置为起点粘贴区域的音乐方块，您当前的粘贴方式为%d",
                "#c36B5B0Use the Arctic Staff to paste the music blocks in the area from your position. Your current pasting method is %d",
            },
            pasteTip2 = {
                "#c9DD8C8粘贴方式枚举 1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴",
                "#c9DD8C8Way 1:Paste regardless of beam line 2.Paste regardless of any blocks except circuits 3:Paste regardless of any blocks"
            },
            pasteTip3 = {
                "#c8bf6ab手持极寒域法杖输入1 2 3 可改变粘贴的策略",
                "#c8bf6abHold the Arctic Staff and input 1~3 to change the pasting strategy",
            },
        },
        drum = {
            drumtip = {
                "#cBEEBE9鼓：输入t/f控制状态(不限大小写)\nt:像音调方块一样在玩家位置处生成\nf:像乐器一样用平凡法杖放",
                "#cBEEBE9Drum: Enter t/f to control the state (no uppercase or lowercase)\nt: generated at the player's position like a tone block\nf: placed with a mundane staff like an instrument block",
            },
            displaystate = {
                "#cFFFDF9您当前的鼓方块生成状态为：%s",
                "#cFFFDF9Your current drum block generation status is: %s",
            },
            tipAfterChange = {
                "#cFFE3ED您的鼓方块生成状态已经改变为：%s",
                "#cFFE3EDYour drum block generation status has changed to: %s",
            },
        },
        Brush = {
            tip = {
                "#cFCD1D1乐器刷子：输入t/f控制刷子开关，不分大小写，t:开，f:关",
                "#cFCD1D1Instrument brush: input t/f to control the brush switch, not case sensitive, t: on, f: off"
            },
            tip2 = {
                "#cFCD1D1当前状态：%s，\n输入1~10数字改变刷子大小，当前大小：%d",
                "#cFCD1D1Current state: %s,\nEnter a number from 1 to 10 to change the brush size, current size: %d",
            },
            afterChangeState = {
                "#cECE2E1您的乐器刷子开关状态已被设置为%s",
                "#cECE2E1Your instrument brush switch state has been set to %s",
            },
            afterChangeSize = {
                "#cD3E0DC您的乐器刷子大小已被设置为%d",
                "#cD3E0DCYour instrument brush size has been set to %d",
            },
            noData = {
                "#cAEE1E1您还没有录入乐器方块数据，无法打开刷子",
                "#cAEE1E1You haven't entered instrument block data yet, can't open the brush",
            },
        },
        MI = {--musical instrument
            brushTip = {
                "#c8bf6ab当前数据：%s %d",
                "#c8bf6abCurrent data: %s %d",
            },
            ztip = {
                "#c8bf6ab当前数据 %s %d %s %d",
                "#c8bf6abCurrent data: %s %d %s %d",
            },
            clearMIDataSuc = {
                "#R清除乐器方块数据成功",
                "#RClear instrument block data successfully",
            },
            entData = {
                "#c66ccff乐器方块生成：#cff7aad录入数据\n#c8bf6ab方块：%s #cB388FF点击次数：%d",
                "#c66ccffInstrument block generation: #cff7aad input data\n#c8bf6ab block: %s #cB388FF clicks: %d"
            },
            entData2 = {
                "#Y手持平凡法杖对准目标位置再次选择该快捷栏可放置方块",
                "#YHold the Ordinary Staff and point it at the target location and select the shortcut bar again to place the block.",
            },
            entData3 = {
                "手持钛合金耙可打开乐器刷子功能",
                "Hold the Titanium Rake to open the instrument brush function",
            },
            entData4 = {
                "#c8bf6ab音调方块：%s #cB388FF点击次数：%d",
                "#c8bf6abTone block: %s #cB388FFClicks: %d",
            },
            pasteSuc = {
                "#c8bf6ab粘贴成功 %s %d %s %d",
                "#c8bf6abPaste successfully %s %d %s %d",
            },
            MIgSuc = {
                "#c8bf6ab乐器方块生成：%s %d",
                "#c8bf6abInstrument block generation: %s %d",
            },
        },
        pat = {
            patTip = {
                "#cF7A4A4pattern工具：请输入字母指令操作 不分大小写",
                "#cF7A4A4Pattern tool: Please enter the letter command operation, regardless of case ",
            },
            patTip2 = {--为什么要分几个写呢 因为一个写不下了awa
                "#cFEBE8Ca.显示pat列表 \nb.将您复制选区的数据录入为pat \nc.显示pat列表并重命名指定pat",
                "#cFEBE8Ca. Display the pat list \nb. Enter the data of the selected area you copied as pat \nc. Rename the specified pat",
            },
            patTip3 = {
                "#cFFFBC1就绪的pattern为%d 使用复苏法杖在您的位置粘贴",
                "#cFFFBC1The ready pattern is %d, Paste at your location using the wand of revival",
            },
            noPatData = {
                "#cB6E2A1您还没有pattern 请先录入pat数据",
                "#cB6E2A1You don't have a pattern yet, please enter the pat data first",
            },
            displayTemplate = { --输出pat数据的模板 
                "#cA8D8EAID:%d 名称:%s \n丨作者:%s 大小:(%d,%d,%d)",
                "#cA8D8EAID: %d Name: %s \n 丨 Author: %s Size: (%d,%d,%d)",
            },
            copyToPatNoData = {
                "#cAA96DA您还没有选区数据 请您先用雷电法杖框选复制选区",
                "#cAA96DAYou don't have the constituency data yet, please use the lightning wand to select and copy the constituency first",
            },
            copyToPatSuc = {
                "#cFCBAD3成功录入pattern数据 \npatId:%d 名称:%s",
                "#cFCBAD3Successfully entered pattern data \npatId:%d Name:%s",
            },
            copyToPatFail = {
                "#cFFFFD2录入数据失败",
                "#cFFFFD2Failed to enter data",
            },
            renameTip = {
                "#cD77FA1输入您想要重命名的pat的id进行选中",
                "#cD77FA1Enter the id of the pat you want to rename to select",
            },
            renameTip2 = {
                "#cE6B2C6您已选中%d pat 输入它的新名字为它重命名",
                "#cE6B2C6You have selected %d pat, Enter its new name to rename it",
            },
            renameSuc = {
                "#cFEF6FB成功将%s重命名为%s",
                "#cFEF6FBSuccessfully renamed %s to %s",
            },
            pasteNoSpec = {
                "#cD6E5FA您还没有指定要粘贴的PatId 输入数字可指定",
                "#cD6E5FAYou have not specified the PatId to paste. Enter a number to specify it.",
            },
            pastePatSuc = {
                "#cFDEFF4成功粘贴pattern Id:%d",
                "#cFDEFF4Pattern Id:%d successfully pasted",
            },
            specPatSuc = {
                "#cFFC0D3已选中Id为%d的patten",
                "#cFFC0D3The pattern whose Id is %d has been selected",
            },
            revokeSuc = {
                "#cFF5C8D撤销成功",
                "#cFF5C8DCanceled successfully",
            },
        },
        globalSetTip = {
            menu = {
                "#c8bf6ab输入数字执行/Enter numbers to execute",
                "#c8bf6abEnter numbers to execute/输入数字执行",
            },
            menu2 = {
                "#c8bf6ab1.使用说明\n2.道具介绍\n3.Switch to English\n4/5.打开/关闭飞行",
                "#c8bf6ab1.Instructions for use\n2.Introduction to props\n3.切换为 中文\n4/5.Turn fly on/off",
            },
            menu3 = {
                "#c8bf6ab6.设置调性\n7.设置位置偏移\n8.查看当前全局设置\n9.我的音轨是折叠的 呈S形",
                "#c8bf6ab6.Set tonality\n7.Set position offset\n8.View current global settings\n9. My audio track is folded into an S shape",
            },
            toneDisplayTemplate = {
                "#c8bf6ab%d.#cffffff%6s #c8bf6ab%s",
                "#c8bf6ab%d.#cffffff%6s #c8bf6ab%s",
            },
            setDisTem = {
                "#c3BB4C1\n音调：%s %s\n位置偏移：(%d,%d,%d)",
                "#c3BB4C1Current setting:\nKey: %s %s\nPosition offset: (%d,%d,%d)"
            },
            setDisFold = {
                "#c3BB4C1\n音调：%s %s\n位置偏移：%d，周期：%d\n左轨位置：%d",
                "#c3BB4C1Current setting:\nKey: %s %s\nPosition offset: %d Period: %d\nLeft Track: %d"
            },
            setPitchTip = {
                "#c048998输入数字选择调性",
                "#c048998Enter number to select Key",
            },
            setPitchTipSuc = {
                "#c0E9577成功将调式设置为#cffffff%s",
                "#c0E9577Successfully set the mode to #cffffff%s",
            },
            setOffsetTip = {
                "#cEFF8FF请输入您要设置的x y z方向的偏移格数 用空格隔开",
                "#cEFF8FFPlease enter the number of offsets in the x, y, and z directions you want to set, separated by sp丨aces",
            },
            setOffsetErrInp = {
                "#cFFE5B9输入格式不正确，请输入三个整数，用空格分隔。",
                "#cFFE5B9The input format is incorrect. Please enter three integers separated by sp丨aces.",
            },
            setOffsetSuc = {
                "#cC9CBFF已将位置偏移设置为(%d, %d, %d)",
                "#cC9CBFFThe position offset has been set to (%d, %d, %d)",
            },
        },
        reaper = {
            reaperTip = {
                "#c8bf6ab手持道具收割者点击方块可将其清除",
                "#c8bf6abHold the Reaper and click on the block to clear it",
            },
        },
        blockTip = {
            tip1 = {
                "方块名称：#W%s#n ID：#W%d",
                "Block name: #W%s#n ID: #W%d",
            },
            tip2 = {
                "坐标#W(%d,%d,%d) #n方块data：#W%d",
                "Pos:#W(%d,%d,%d)#n block data: #W%d"
            },
        },
        item = {--玩家对道具操作
            getCurToolID = {
                "道具名称：#W%s，#nID：#W%d",
                "Item name: #W%s, #nID: #W%d",
            },
        },
        attr = { --玩家属性
            Horas1 = {
                "#c8bf6ab使用星铜钻头，向前冲刺\n输入A B C 修改配置\n#Wa.输入数字设置自己的移动速度(x>=0,默认为10)",
                "#c8bf6abDash forward using this item\nEnter A/B/C: Modify config\n#Wa. Set movement speed (x>=0, default: 10)",
            },
            Horas2 = {
                "#cffffffb.输入数字设置自己的模型大小(x=0,默认为1)\nc.输入数字设置自己的弹飞力度(建议非负,默认为10)",
                "#cffffffb. Set your model size (x=0, default: 1)\nc. Set your knockback strength (recommended non-negative, default: 10)",
            },
            impNum = {
                "#c66ccff请输入一个数字",
                "#c66ccffPlease input a number",
            },
            impNumIllegal = {
                "#c8bf6ab您的输入不在可接受区间，请重新输入",
                "#c8bf6abYour input is not within the acceptable range, please re-enter",
            },
            changeSpeedSuc = {
                "#c8bf6ab成功将您的移动速度改为%s",
                "#c8bf6abSuccessfully changed your movement speed to %s",
            },
            changeSizeSuc = {
                "#c8bf6ab成功将您的模型大小改为%s",
                "#c8bf6abSuccessfully changed your model size to %s",
            },
            changeForceSuc = {
                "#c8bf6ab成功将您的弹飞力度改为%s",
                "#c8bf6abSuccessfully changed your launch force to %s",
            },
        },
        fold = { --关于折轨的
            tip1 = {
                "#c7BD3EA如果你的音乐地图采用的是折叠音轨 我们需要简单配置一下您的位置偏移",
                "#c7BD3EAIf your music map uses folded tracks, we need to simply configure your position offset",
            },
            tip2 = {
                "#cA1EEBD请确保每行音轨的间距相等 否则可能导致偏移错误",
                "#cA1EEBDPlease ensure that the spacing between each row of tracks is equal, otherwise it may cause offset errors",
            },
            tip3 = {
                "#cF6F7C4现在 请您背对音乐地图的起点 面朝终点 告诉我您的前方是什么方向",
                "#cF6F7C4Now, face the ending direction with your back to the music map's starting point. What direction is ahead of you.",
            },
            tip4 = {
                "#cF6D6D6输入一个数字以选择",
                "#cF6D6D6Enter a number to select",
            },
            chooseDirSuc = {
                "#cFFE5E5成功选择方向！",
                "#cFFE5E5Successfully choose the direction!",
            },
            trackTip = {
                "#cE0AED0请任意找两行相邻且反方向的音轨 分别站在向左/向右的轨上输入L/R 不分大小写",
                "#cE0AED0Identify two neighboring tracks facing opposite directions. Stand on the left/right track and input L/R, case-insensitive.",
            },
            trackTip2 = {
                "#cE0AED0请先确定向左的轨的位置",
                "#cE0AED0lease determine the position of the left track first",
            },
            trackTip3 = {
                "#cAC87C5确定向左的轨位置成功\n请确定向右的轨的位置",
                "#cAC87C5Determine the position of the left track successfully. Please confirm the position of the right track",
            },
            trackTip4 = {
                "#cAC87C5确定向右的轨的位置成功\n请输入一个数字设置您的偏移量",
                "#cAC87C5Determining the position of the right track successfully. Please enter a number to set your offset",
            },
            foldSuc = {
                "#c756AB6成功为您的折叠轨地图配置了偏移！",
                "#c756AB6Successfully configured offset for your folded track map!",
            },
        },
        armAndGiant = { --巨人核心和推拉机械臂的提示
            tip = {
                "#c66ccff输入数字在您的位置生成%s\n方向: 0.西, 1.东\n2.北, 3.南\n4.下, 5.上",
                "#c66ccffEnter num to gen %s at your location\nDirections: 0. West, 1. East\n 2. North, 3. South\n 4. Down, 5. Up",
            },
        },
        areaOperations = {
            indexTip = {
                "#c8bf6ab在区域中检测到以下数据",
                "#c8bf6abThe following data was detected in the area",
            },
            formatMsg = "%d. #W%s#n id: #W%d#n, data: #W%d",
            replaceSuc = {
                "#c8bf6ab区域内方块替换成功",
                "#c8bf6abBlock replacement in the area was successful",
            },
        },
        transpose = {
            inputErr = {
                "#cF6D6D6输入错误 仅能接受-12到12范围内的整数",
                "#cF6D6D6Input error, only integers in the range -12 to 12 can be accepted",
            },
            transSuc = {
                "#c8bf6ab移调成功",
                "#c8bf6abTransposed successfully",
            },
            tip1 = {
                "#c66ccff现在你可以在聊天框输入命令来进行以下操作",
                "#c66ccffNow you can enter commands in the chat box to perform the following operations",
            },
            ordTip1 = {
                "#W/trans #nsemitoneNum #cF6F4EB对选区内所有音调方块移调 参数是半音数 可接受-12 ~ 12",
                "#W/trans #nsemitoneNum #cF6F4EBTransposes all pitch blocks in the selection. Argument: Semitones count. Range: -12 ~ 12",
            },
            ordTip2 = {
                "#W/index #c91C8E4为区域的音乐方块创建索引 没有参数",
                "#W/index #c91C8E4Creates an index for the area's music cube, no argument",
            },
            ordTip3 = {
                "#W/replace #nindex id data #c7895CB指定选区索引对应的方块种类和data",
                "#W/replace #nindex id data #c7895CBSelect the block type and data corresponding to the selection index",
            },
            ordTip4 = {
                "#c7895CB并将其替换成你所指定的方块id和data 参数是索引 替换后的id和data",
                "#c7895CBreplace it with the block id and data you specified, argument: index, replaced id and data",
            },
            ordTip5 = {
                "#W/del #nindex #c4682A9删除区域内指定索引的方块",
                "#W/del #nindex #c4682A9Delete the block at the specified index in the area",
            },
            ordTip6 = {
                "#W/clear #c164B60清空区域内所有的音乐方块 无参数",
                "#W/clear #c164B60Clear all the music block in the area, no argument",
            },
            clearSuc = {
                "#W清除成功",
                "#WCleared successfully",
            },
            delSuc = {
                "#W删除成功",
                "#WDeleted successfully",
            },
        },
    },

    order = { --指令
        cancel = {
            "撤销",
            "Undo",
        },
        clearMIData = {
            "清除乐器方块数据",
            "Clear instrument block data",
        },
    },
}

--使用说明列表
local readme = {
    {
        "#c8bf6ab『异端世方』音乐方块生成器★v1.13\n            使 ★ 用 ★ 说 ★ 明",
        "#c66ccff==========================",
        "#cFFFF81通用功能：",
        "#cFFACAC1. 手持收割者查看基础功能及设置菜单。",
        "2. 音乐组复制功能：手持平凡法杖撸一下乐器方块来录入音组数据，手持平凡法杖再次选择该快捷栏可在准星位置粘贴音组。",
        "#cFFEBB43. 手持道具收割者点击方块可将其清除。",
        "#cFBFFB14. 手持非收割者道具点击方块，检测方块的属性",
        "#cFFF4D25. 使用平凡法杖，瞬移到准星位置",
        "#cEED7CE6. 使用星铜钻头，向前冲刺。还可以调整玩家移动速度和模型大小。",
        "#c92C7CF7. 手持巨人核心输入数字可在玩家位置处生成",
        "#cAAD7D98. 手持推拉机械臂输入数字可在玩家位置生成，并附带一个电源",
        "#cFBF9F1",
        "#cE5E1DA",
        "#cFFFF81音调方块的生成：",
        "#cE5D1FA1. 手持高中低音块，站在目标位置上，输入音块的点击次数(0~12)或音名(CDEFGAB)可生成音调方块。",
        "#cE3DFFD2. 音调方块生成后，可以对玩家做一个位置偏移以避免被生成的方块卡住。可以手持收割者设置这个偏移的值。",
        "#cECF2FF3. 手持音调方块输入空格做一次偏移",
        "#cFFFF81乐器方块的生成：",
        "#cFFE5E51. 手持鼓、电子、综合、乐器方块，输入音块的点击次数，手持平凡法杖再次选择该快捷栏可在准星位置生成对应的音乐方块。",
        "#cFBA1B72. 切换音色：手持对应乐器方块重新输入数字即可，这会覆盖复制的音组数据。",
        "#cFFD1DA3. 清除保存的数据：在聊天框输入“清除乐器方块数据”来清除，再次选择平凡法杖快捷栏不会生成方块。",
        "#cFFF0F54. 乐器刷子功能：钛合金耙控制，开启后，玩家行走时，在玩家周围未放乐器的音调方块上刷上录入的乐器",
        "#cFFFF81鼓方块的生成：",
        "#cFFDBAA1. 鼓方块可以用以上两种方式生成 手持鼓方块可以查看操作提示",
        "#cFFFF81区域音乐方块复制（雷电法杖与极寒域法杖）：",
        "#cFEFCF31. 用雷电法杖锚定区域起点和终点框选欲复制的区域，方法如下一条所示",
        "#cF5EBE02. 手持雷电法杖使用一下（按右键）可在玩家位置锚定一个点，撸一下方块可以在方块位置锚定一个点",
        "#cF0DBDB3. 两种方法都可以使用，具体依据个人需求",
        "#cDBA39A4. 框选好区域后，再使用一次手中的雷电法杖，系统会录入待复制的区域中所有音乐方块的数据",
        "#cFAF3F05. 复制好后，使用极寒域法杖，以自己的位置为起点，粘贴音乐方块",
        "#cD4E2D46. 手持极寒域法杖，在聊天框输入“撤消”可撤消刚刚粘贴的东西，但使用2和3方式粘贴时被破坏的方块无法恢复",
        "#cFFCACC7. 在锚定点后，切换道具可取消所有锚定的点，再次选择雷电法杖快捷栏可取消区域的终结点",
        "#cDBC4F08. 手持极寒域法杖，输入数字可改变粘贴方式。 1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴",
        "#cB1B2FF9. 在持有区域的情况下，依提示输入命令实现选区移调和乐器替换等功能",
        "#cFFFF81Pattern功能",
        "#cB0DAFF1. 手持复苏法杖可依提示进行pattern操作",
        "#cDAF5FF2. 使用复苏法杖粘贴就绪的pattern",
        "#c66ccff==========================",
    },
    {
        "#c8bf6abMusic Block Generator★v1.13 by Heresy Shifang Studio",
        "#c66ccff==========================",
        "#cFFFF81General Functions:",
        "#cFFACAC1. Hold the Reaper to view basic functions and settings menu.",
        "#cFFBFA92. Music Group Copying: Use the Ordinary Wand to record music group data by interacting with an instrument block.",
            "#cFFBFA9Use the Ordinary Wand again to paste the music group at the crosshair position.",
        "#cFFEBB43. Click a block with the Reaper to remove it.",
        "#cFBFFB14. Click a block with a non-Reaper item to inspect its properties.",
        "#cFFF4D25. Use the Ordinary Wand to teleport to the crosshair position.",
        "#cEED7CE6. Use the Horas Copper Drill to dash forward. Player movement speed and model size can also be adjusted in this.",
        "#c92C7CF7. Holding the Giant Core and inputting numbers can generate it at your position.",
        "#cAAD7D98. Holding a Push-pull Robot Arm and input num can generate at your position and comes with a power supply",
        "#cFBF9F1",
        "#cE5E1DA",
        "#cFFFF81Music Note Block Generation:",
        "#cE5D1FA1. Hold High, Middle, or Low Note Blocks, stand at the target location,",
            "#cE5D1FAand enter the number of clicks (0~12) or a note name (CDEFGAB) to generate a music note block.",
        "#cE3DFFD2. After generating a music note block, you can apply a player position offset to prevent block obstruction.",
            "#cE3DFFDYou can use the Reaper to set this offset value.",
        "#cECF2FF3. Hold the node block and enter a sp丨ace to make an offset",
        "#cFFFF81Musical Instrument Block Generation:",
        "#cFFE5E51. Hold Drum, Electronic, Composite Musical Instrument Blocks, enter the number of clicks,",
            "#cECF2FFand use the Ordinary Wand to generate corresponding music blocks at the crosshair position.",
        "#cFBA1B72. Change the instrument: Hold the corresponding musical instrument block and re-enter the number.",
            "#cFBA1B7This will overwrite the copied music group data.",
        "#cFFD1DA3. Clear saved data: Enter 'Clear instrument block data' in the chat to clear it.",
            "#cFFD1DASelecting the Ordinary Wand shortcut again will not generate blocks.",
        "#cFFF0F54. Instrument Brush function: Controlled by Titanium Rake,",
            "#cFFF0F5it paints the recorded instruments on music note blocks around the player when walking.",
        "#cFFFF81Drum Block Generation:",
        "#cFFDBAA1. Drum blocks can be generated using the above two methods. Hold a drum block to view the operation prompt.",
        "#cFFFF81Area Music Block Copying (Thunderstaff and Frostbite Staff):",
        "#cFEFCF31. Use the Thunderstaff to mark the start and end points of the area you want to copy.",
            "#cFEFCF3Methods are described in the next point.",
        "#cF5EBE02. Hold the Thunderstaff and use it once to anchor a point at your player's position.",
            "#cF5EBE0Use it on a block to anchor a point at the block's position.",
        "#cF0DBDB3. Both methods can be used, depending on personal preferences.",
        "#cDBA39A4. After selecting the area, use the Thunderstaff again to record the data of all music blocks in the designated area.",
        "#cFAF3F05. After copying, use the Frostbite Staff, starting from your position, to paste music blocks.",
        "#cD4E2D46. Hold the Frostbite Staff and enter 'Undo' in the chat to undo the paste,",
            "#cD4E2D4but blocks destroyed during paste with methods 2 and 3 cannot be recovered.",
        "#cFFCACC7. After anchoring points, changing items cancels all anchored points.",
            "#cFFCACCSelecting the Thunderstaff shortcut again cancels the area's endpoint.",
        "#cDBC4F08. Hold the Frostbite Staff and enter a number to change the paste method. 1: Paste without regard to beam",
            "#cDBC4F0line (default)2: Paste without regard to any block except for circuits 3: Paste without regard to any block.",
        "#cB1B2FF9. While holding the area, follow the prompts to enter commands to implement functions",
            "#cB1B2FFsuch as selection transposition and instrument replacement",
        "#cFFFF81Pattern Function:",
        "#cB0DAFF1. Hold the Resurgence Wand and follow the prompts to perform pattern operations.",
        "#cDAF5FF2. Use the Resurgence Wand to paste prepared patterns.",
        "#c66ccff==========================",
    },
}

local itemIntro = {
    {
        "#c8bf6ab          ~ 道 ★ 具 ★ 介 ★ 绍 ~",
        "#c66ccff==========================",
        "#cEF9595低中高音块：音调方块生成功能",
        "#cEFB495平凡法杖：放置乐器方块、瞬移",
        "#cEFD595乐器方块：录入数据后可用平凡法杖放置",
        "#cEBEF95鼓方块可以用以上两种生成方式",
        "#cEEEEEE收割者：清除方块与基础设置",
        "#c64CCC5雷电法杖与极寒域法杖：区域的复制粘贴",
        "#c176B87钛合金耙：控制乐器刷子",
        "#c053B50复苏法杖：pattern录入、操作、粘贴",
        "#cFED9ED星铜钻头：使用向前冲刺、控制玩家移动速度和模型大小",
        "#cE7BCDE巨人核心：输入数字生成",
        "#cBB9CC0推拉机械臂：输入数字生成 附带一个花纹星能块",
        "#c67729D",
        "#c66ccff==========================",
    },
    {
        "#c8bf6ab           ~ Item Introduction ~",
        "#c66ccff==========================",
        "#cEF9595Low, Medium, High Note Blocks: Used for generating music note blocks.",
        "#cEFB495Ordinary Wand: Places instrument blocks and allows teleportation.",
        "#cEFD595Instrument Blocks: Can be placed using the Ordinary Wand after data recording.",
        "#cEBEF95Drum Blocks can be generated using the above two methods.",
        "#cEEEEEEReaper: Clears blocks and basic settings.",
        "#c64CCC5Thunderstaff and Frostbite Staff: Copy and paste for areas.",
        "#c176B87Titanium Rake: Controls the instrument brush.",
        "#c053B50Resurgence Wand: Pattern recording, operations, and pasting.",
        "#cFED9EDHoras Copper Drill: Forward dash, control player movement speed and model size",
        "#cE7BCDEGiant Core: Enter number to generate",
        "#cBB9CC0Push-pull Robot Arm: Enter number to generate, Place a Patterned Celesthium Block at the same time",
        "#c67729D",
        "#c66ccff==========================",
    },
}

local intro = {
    {
        "#c8bf6ab『异端世方』音乐方块生成器★v1.13",
        "#c66ccff==========================",
        "#c61C0BF作者：欧阳闻奕（OWALabuy）",
        "#cBBDED6迷你号 5丨2丨8丨2丨7丨8丨7丨0丨3",
        "#cFAE3D9选择收割者查看菜单 / Select",
        "#cFFB6B9the Reaper to view the menu",
        "#c66ccff=========================="
    },
    {
        "#c8bf6abMusic Block Generator★v1.13",
        "#c66ccff==========================",
        "#c61C0BFby Heresy Shifang Studio",
        "#cBBDED6Author:OWALabuy (欧阳闻奕)",
        "#cFAE3D9Select the Reaper ",
        "#cFFB6B9to view the menu",
        "#c66ccff=========================="
    },

}


---------------------- 变量及数据库 ----------------------
local PDB={}
--[[playerDataBase 玩家数据库 数据结构如下
    PDB[UIN]={
        ( 这部分可能没有 开头不定义
            block_id(乐器方块的id) 
            click_num(乐器方块的点击次数) 
            z_bloid z_num(复制音组时 音调方块的id和点击次数 可能没有此数据)
        )
        switch = false, (音乐方块的特效提示开关)
        DrumState = false, (鼓的状态 t:像音调方块一样在玩家位置处生成 f:像乐器一样用平凡法杖放)
        
        Brush = {
            state = false, --刷子的开关状态 通过手持钛合金耙输入tf控制
            size = 2, --刷子的大小 通过手持钛合金耙输入数字控制 范围1~10 默认为2
        },
        
        copy = { (复制区域内音乐方块用的数据库）
            way = 1,
            pos = {<粘贴的方法枚举  1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴> 
                strpos = {}, <里面有两个table 分别为 strpos endpos 格式形如{x=2,y=3,z=4}>
                endpos = {},
            },
            keepPos = { --保存玩家的区域坐标
                strpos = {}, 
                endpos = {},
            },
            vector = {},<向量坐标 代表区域的大小和相对于起点坐标的方向 形如{x=2,y=3,z=4} 末位置减去初位置> 
            direction = {},<向量的方向 如 {x=1,y=1,z=1}>
            areadata = {},<区域的数据 是一个三维的tab 每个元素的索引为其在向量中的相对坐标 形如PDB[528278703]["copy"]["areadata"][3][1][2] val为一个tab 里面有id和data 形如PDB[528278703]["copy"]["areadata"][3][1][2][id] 从起点坐标开始遍历整个区域 录入每个方块的id的data>
            LastPastePos = {}, <上次粘贴的坐标 用于撤销>
        },
        pattern = { --玩家pattern控制状态
            rename = false, --重命名的状态 
            renameId = -1, --要重命名的patId 
            nowPatId = -1,--当前准备就绪要粘贴的patId
            LastPastePatPos = {}, --上次粘贴pat的位置
            lastPasPatId = -1 --上次粘贴的patId
            },
        },
        attr = { --玩家属性 attributes
            force = 10, --弹飞 力度 默认为10
            speed = false, --改变速度的状态
            size = false, --改变模型大小的状态
            setForce = false, --改变弹飞力度大小的状态
        },
        areaBlockData = {--这是遍历区域后所得的区域原始数据 这个表和下个表在 选区音块操作 和 选区所有方块操作 中共用
            [blockId1] = {data1, data2, ...},
            [blockId2] = {data1, data2, ...},
        },
        areaBlockDataIndex = {--遍历完成后 统计areaBlockData表中数据并生成索引 这两个表在玩家切换道具后清空
            [1] = {id = 1, data = 0},
            ...
        },
        areaPAT = { --存储玩家框选的装饰区域的数据 准备制作pat 也可以用来做id data替换
            rename = false, --重命名的状态 
            renameId = -1, --要重命名的patId 
            nowPatId = -1,--当前准备就绪要粘贴的patId
            LastPastePatPos = {}, --上次粘贴pat的位置
            lastPasPatId = -1 --上次粘贴的patId
            },
            way = 1,<粘贴的方法枚举  1:无视光束线粘贴(默认) 2.无视除电路外任何方块粘贴 3:无视任何方块粘贴> 
            pos = {
                strpos = {}, <里面有两个table 分别为 strpos endpos 格式形如{x=2,y=3,z=4}>
                endpos = {},
            },
            LastPastePos = {}, <上次粘贴的坐标 用于撤销>
        },
    }
    --]]

local PAT = { --pattern的数据库
    count = 0, --现在有多少个pat
    data = {}, --这个东西里面的数据结构如下
    --[[ data的数据结构 PAT.data[patId].
        [patId] = {
            name = "pat" .. count, --默认名字
            authorName = "",
            authorUIN = ,
            pos = {
                strpos = {},
                endpos = {},
            },
            vector = {},<向量坐标 代表区域的大小和相对于起点坐标的方向 形如{x=2,y=3,z=4} 末位置减去初位置> 
            direction = {},<向量的方向 如 {x=1,y=1,z=1}>
            areadata = {},<区域的数据 是一个三维的tab 每个元素的索引为其在向量中的相对坐标 形如PDB[528278703]["copy"]["areadata"][3][1][2] val为一个tab 里面有id和data 形如PDB[528278703]["copy"]["areadata"][3][1][2][id] 从起点坐标开始遍历整个区域 录入每个方块的id的data>
    }
    --]]
}

local areaPAT = { --区域（装饰用）pat 录入的是所有方块的数据 不只有音乐方块
    count = 0, --现在有多少个pat
    data = {}, --这个东西里面的数据结构如下
    --[[ data的数据结构 PAT.data[patId].
        [patId] = {
            name = "pat" .. count, --默认名字
            authorName = "",
            authorUIN = ,
            pos = {
                strpos = {},
                endpos = {},
            },
            vector = {},<向量坐标 代表区域的大小和相对于起点坐标的方向 形如{x=2,y=3,z=4} 末位置减去初位置> 
            direction = {},<向量的方向 如 {x=1,y=1,z=1}>
            areadata = {},<区域的数据 是一个三维的tab 每个元素的索引为其在向量中的相对坐标 形如PDB[528278703]["copy"]["areadata"][3][1][2] val为一个tab 里面有id和data 形如PDB[528278703]["copy"]["areadata"][3][1][2][id] 从起点坐标开始遍历整个区域 录入每个方块的id的data>
    }
    --]]
}

local Itemid_List={ --要检测和添加的初始道具列表
    690,691,692, --音调方块 低中高
    11580, --平凡法杖 放置乐器方块 瞬移
    693,694,695, --乐器方块 鼓 电子 综合
    12009, --收割者 清除方块 基础设置
    11582,11668, --雷电法杖与极寒域法杖 复制粘贴区域
    11034, --钛合金耙 乐器刷子道具
    11584, --复苏法杖 pattern录入 操作 粘贴
    11016, --星铜钻头 玩家移动速度控制 玩家模型大小控制
    368, --推拉机械臂 花纹电石块是1104
    1059, --巨人核心
}

local globalSetState = {
    chooseKey = false, --设置调性
    setOffset = false, --设置位置偏移
    setFold = false, --设置折轨
    chooseFoldPara = false, --设置折轨的参数
    setLeftPos = false, --设置向左向右的轨的状态
    setRightPos = false,
    setFoldOffset = false, --设置偏移量
}

local fold = { --地图的折轨设定 这里的数值全是乱写的 数据等待玩家注入
    axis = "Z", --用来在foldpara中找参数 下同 X或Z
    direction = 1, --  1 或 -1
    offset = 2, --向左或向右偏移的格式
    leftTrackKeyPos = 4, --向左的音轨的关键坐标 (视方向而定 比如x轴就记录x坐标)
    rightTrackKeyPos = 1, --向右的音轨的关键坐标(只记录X值或Z值)
    leftTrackInPeriod = 1, --向左的轨在周期中的位置
    distance = 1.5, --轨距离的二分之一 用于判断玩家的坐标
    period = 6, --周期 也就是轨距离的二倍
}

local foldList = { --折轨的情况列表 玩家选了就注入到fold表中
    [1] = {
        axis = "Z",
        direction = 1,
    },
    [2] = {
        axis = "Z",
        direction = -1,
    },
    [3] = {
        axis = "X",
        direction = 1,
    },
    [4] = {
        axis = "X",
        direction = -1,
    },

}

local foldPara = { --折轨的有关参数
    X = {
        [1] = {
            ind = 3,
            direction = {
                "#cffffff东方，X轴正方向",
                "#cffffffEast, positive direction of X axis",
            },
            left = { --这是倍数 也就是偏移的时候对应坐标轴的方向
                x = 0,
                z = 1,
            },
            right = {
                x = 0,
                z = -1,
            },
        },
        [-1] = {
            ind = 4,
            direction = {
                "#c66ccff西方，X轴负方向",
                "#c66ccffWest, negative direction of X axis",
            },
            left = {
                x = 0,
                z = -1,
            },
            right = {
                x = 0,
                z = 1,
            },
        },
    },
    Z = {
        [1] = {
            ind = 1, --在foldlist中的索引
            direction = {
                "#cffffff北方，Z轴正方向",
                "#cffffffNorth, positive direction of Z axis",
            },
            left = { --这是倍数 也就是偏移的时候对应坐标轴的方向
                x = -1,
                z = 0,
            },
            right = {
                x = 1,
                z = 0,
            },
        },
        [-1] = {
            ind = 2,
            direction = {
                "#c66ccff南方，Z轴负方向",
                "#c66ccffSouth, negative direction of Z axis",
            },
            left = {
                x = 1,
                z = 0,
            },
            right = {
                x = -1,
                z = 0,
            },
        },
    },
}

local robotArmDir = { --推拉机械臂放置后 电石块应该放在哪里
    [0] = {x = -1, y = 0, z = 0},
    [1] = {x = 1, y = 0, z = 0},
    [2] = {x = 0, y = 0, z = -1},
    [3] = {x = 0, y = 0, z = 1},
    [4] = {x = 0, y = -1, z = 0},
    [5] = {x = 0, y = 1, z = 0},
}

local Lang = 1 --语言language 1:简体中文 2:English
local CopyEffectId = 1212 --复制用的特效id
local offset = {x=0, y=0, z=0} --位置偏移
local isFold = false --是否是折叠轨（玩家可以配置折叠轨相关的参数）
local pitch = 1 --调性
local pitchList = {--调性调用的东西
    [1] = {
        name = "C/Am", intro = "C D E F G A B",
        tone = {c=0, d=2, e=4, f=5, g=7, a=9, b=11},
    },
    [2] = {
        name = "Db/Bbm", intro = "C Db Eb F Gb Ab Bb",
        tone = {c=0, d=1, e=3, f=5, g=6, a=8, b=10},
    },
    [3] = {
        name = "D/Bm", intro = "C# D E F# G A B",
        tone = {c=1, d=2, e=4, f=6, g=7, a=9, b=11},
    },
    [4] = {
        name = "Eb/Cm", intro = "C D Eb F G Ab Bb",
        tone = {c=0, d=2, e=3, f=5, g=7, a=8, b=10},
    },
    [5] = {
        name = "E/C#m", intro = "C# D# E F# G# A B",
        tone = {c=1, d=3, e=4, f=6, g=8, a=9, b=11},
    },
    [6] = {
        name = "F/Dm", intro = "C D E F G A Bb",
        tone = {c=0, d=2, e=4, f=5, g=7, a=9, b=10},
    },
    [7] = {
        name = "F#/Ebm", intro = "C# D# E# F# G# A# B",
        tone = {c=1, d=3, e=5, f=6, g=8, a=10, b=11},
    },
    [8] = {
        name = "G/Em", intro = "C D E F# G A B",
        tone = {c=0, d=2, e=4, f=6, g=7, a=9, b=11},
    },
    [9] = {
        name = "Ab/Fm", intro = "C Db Eb F G Ab Bb",
        tone = {c=0, d=1, e=3, f=5, g=7, a=8, b=10},
    },
    [10] = {
        name = "A/F#m", intro = "C# D E F# G# A B",
        tone = {c=1, d=2, e=4, f=6, g=8, a=9, b=11},
    },
    [11] = {
        name = "Bb/Gm", intro = "C D Eb F G A Bb",
        tone = {c=0, d=2, e=3, f=5, g=7, a=9, b=10},
    },
    [12] = {
        name = "B/G#m", intro = "C# D# E F# G# A# B",
        tone = {c=1, d=3, e=4, f=6, g=8, a=10, b=11},
    },
}

---------------------- 函数重构 ----------------------

--对玩家显示聊天框系统消息(重构) 参数是字符串和玩家迷你号 规范化参数避免缺参
local function msg(content, UIN)
    if(content and UIN == nil) --检查参数是否完整
    then
        Chat:sendSystemMsg('msg:参数不完整！')
        return 1001
    end
    Trigger:wait(0.1) --一个小的延迟
    if(type(content) ~= "string")--类型转换
    then
        content = tostring(content)
    end
    Chat:sendSystemMsg(content, UIN)
    return 0
end

--对玩家显示飘窗文字(重构) 参数是字符串和玩家迷你号 规范化参数避免缺参
local function notify(content, UIN)
    if(content and UIN == nil) --检查参数是否完整
    then
        Chat:sendSystemMsg('notify:参数不完整！')
        return 1001
    end
    Player:notifyGameInfo2Self(UIN, content)
    return 0
end

---------------------- 函数定义 ----------------------


--对玩家输出使用说明 参数是玩家的迷你号
local function user(UIN)
    Trigger:wait(0.1)
    for i = 1, #readme[Lang]
    do
        Chat:sendSystemMsg(readme[Lang][i], UIN) --逐条输出
        if(i>=3)
        then
            Trigger:wait((#readme[Lang][i]*0.03)) --根据字数设定延迟
        end
    end
    return 0
end

--复制一个区域 录入一个区域的所有音乐方块数据 参数是玩家的迷你号
local function ctrl_c(UIN)
    --消灭掉上次复制的东西
    PDB[UIN].copy.areadata = {}
    --开辟表格 一层套一层 像俄罗斯套娃
    for x = 0, PDB[UIN].copy.vector.x, PDB[UIN].copy.direction.x
    do
        PDB[UIN].copy.areadata[x] = {}
        for y = 0, PDB[UIN].copy.vector.y, PDB[UIN].copy.direction.y
        do
            PDB[UIN].copy.areadata[x][y] ={}
            for z = 0, PDB[UIN].copy.vector.z, PDB[UIN].copy.direction.z
            do
                PDB[UIN].copy.areadata[x][y][z] ={}
            end
        end
    end

    --录入数据
    --遍历每一个方块
    for x = 0, PDB[UIN].copy.vector.x, PDB[UIN].copy.direction.x
    do
        for y = 0, PDB[UIN].copy.vector.y, PDB[UIN].copy.direction.y
        do
            for z = 0, PDB[UIN].copy.vector.z, PDB[UIN].copy.direction.z
            do
                local result,id = Block:getBlockID( PDB[UIN].copy.pos.strpos.x+x, PDB[UIN].copy.pos.strpos.y+y, PDB[UIN].copy.pos.strpos.z+z)
                if(id >= 690 and id <= 699)--如是音乐方块
                then
                    local result,data=Block:getBlockData( PDB[UIN].copy.pos.strpos.x+x, PDB[UIN].copy.pos.strpos.y+y, PDB[UIN].copy.pos.strpos.z+z)
                    --录入id 和data 
                    PDB[UIN].copy.areadata[x][y][z].id = id
                    PDB[UIN].copy.areadata[x][y][z].data = data
                end
            end
        end
    end
    msg(string.format(CL.tip.copy.copySuccessfully[Lang], PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z),UIN)
    msg(CL.tip.copy.copySuccessfully2[Lang], UIN)
    return 0
end

--粘贴方块 根据PDB[UIN].copy.way选择粘贴的方式 参数是玩家的迷你号
local function ctrl_v(UIN)
    --获取玩家位置
    local result,px,py,pz=Actor:getPosition(UIN)
    --将这次粘贴的位置保存到copy中
    PDB[UIN].copy.LastPastePos = {x=px,y=py,z=pz}
    --提取数据
    for x = 0, PDB[UIN].copy.vector.x, PDB[UIN].copy.direction.x
    do
        for y = 0, PDB[UIN].copy.vector.y, PDB[UIN].copy.direction.y
        do
            for z = 0, PDB[UIN].copy.vector.z, PDB[UIN].copy.direction.z
            do
                if(PDB[UIN].copy.areadata[x][y][z].id)
                then
                    local result,BeforeId = Block:getBlockID(px+x, py+y, pz+z)
                    if(PDB[UIN].copy.way == 1) --1.无视光束线粘贴(默认)
                    then
                        if(BeforeId == 0 or BeforeId == 351) --空气或光束线
                        then
                            Block:setBlockAll(px+x, py+y, pz+z, PDB[UIN].copy.areadata[x][y][z].id, PDB[UIN].copy.areadata[x][y][z].data)
                        end
                    elseif(PDB[UIN].copy.way == 2)-- 2.无视除电路外任何方块粘贴
                    then
                        if(not((BeforeId>=352 and BeforeId<=374) or (BeforeId==415) or (BeforeId>=690 and BeforeId<=722))) --排除电路元件和音乐方块
                        then
                            Block:setBlockAll(px+x, py+y, pz+z, PDB[UIN].copy.areadata[x][y][z].id, PDB[UIN].copy.areadata[x][y][z].data)
                        end
                    elseif(PDB[UIN].copy.way == 3)-- 3.无视任何方块粘贴 
                    then
                        Block:setBlockAll(px+x, py+y, pz+z, PDB[UIN].copy.areadata[x][y][z].id, PDB[UIN].copy.areadata[x][y][z].data)
                    end
                end
            end
        end
    end
    msg(string.format(CL.tip.copy.pasteSuc[Lang], px, py, pz),UIN)
    return 0
end

--撤消（消除刚刚粘贴的东西）
local function ctrl_z(UIN)
    --上次粘贴的位置
    local px, py, pz = PDB[UIN].copy.LastPastePos.x, PDB[UIN].copy.LastPastePos.y, PDB[UIN].copy.LastPastePos.z
    for x = 0, PDB[UIN].copy.vector.x, PDB[UIN].copy.direction.x
    do
        for y = 0, PDB[UIN].copy.vector.y, PDB[UIN].copy.direction.y
        do
            for z = 0, PDB[UIN].copy.vector.z, PDB[UIN].copy.direction.z
            do
                if(PDB[UIN].copy.areadata[x][y][z].id) --对比id和data 进行清除操作
                then
                    local result,BeforeId = Block:getBlockID(px+x, py+y, pz+z)
                    if(BeforeId == PDB[UIN].copy.areadata[x][y][z].id)
                    then
                        local result,data=Block:getBlockData(px+x, py+y, pz+z)
                        if(data == PDB[UIN].copy.areadata[x][y][z].data)
                        then
                            Block:destroyBlock(px+x, py+y, pz+z, false)
                        end
                    end
                end
            end
        end
    end
    msg(CL.tip.pat.revokeSuc[Lang], UIN)
    return 0
end

--刷子函数 参数是玩家的迷你号 在玩家周围size大小的区域未放乐器的音调方块上刷上乐器方块
local function Brush(UIN)
    local result, x0, y0, z0=Actor:getPosition(UIN)
    local size = PDB[UIN].Brush.size
    local x1, x2 = x0 - size, x0 + size
    local y1, y2 = y0 - size, y0 + size
    local z1, z2 = z0 - size, z0 + size
    for x = x1,x2
    do
        for y = y1, y2
        do
            for z = z1, z2
            do
                local result,id = Block:getBlockID(x,y,z)
                if(id>=690 and id<=692)--若是音调方块 检测上面的id
                then
                    local result,id2 = Block:getBlockID(x,y+1,z)
                    if(id2==0 or id2==351)--若是空气或光束线
                    then --刷上对应的乐器
                        Block:setBlockAll(x,y+1,z,PDB[UIN].block_id,PDB[UIN].click_num)
                    end
                end
            end
        end
    end
    return 0
end

--对玩家显示pattern列表 参数是玩家的迷你号
local function displayPatList(UIN)
    if(PAT.count == 0)--如果没有pat数据 就直接输出提示
    then
        msg(CL.tip.pat.noPatData[Lang],UIN)
    else --如果有 就跑循环输出每一个pat的信息
        for id = 1, #PAT.data
        do
            msg(string.format(CL.tip.pat.displayTemplate[Lang], id, PAT.data[id].name, PAT.data[id].authorName, PAT.data[id].vector.x, PAT.data[id].vector.y, PAT.data[id].vector.z), UIN)
        end
    end
    return 0
end

--将玩家当前复制的方块数据录入到pat库 参数是玩家的迷你号
local function copyToPat(UIN)
    --检测玩家当前有没有已经复制的数据(通过vector)
    if(PDB[UIN].copy.vector.x)
    then--有数据 录入
        local patId = PAT.count + 1
        local result,name=Player:getNickname(UIN)
        PAT.data[patId] = { --建立一个以count为索引的tab存放pat数据
            name = "pat" .. patId,
            --录入作者信息
            authorName = name,
            authorUIN = UIN,
            --录入区域信息
            pos = {
                strpos = {
                    x = PDB[UIN].copy.keepPos.strpos.x,
                    y = PDB[UIN].copy.keepPos.strpos.y,
                    z = PDB[UIN].copy.keepPos.strpos.z,
                },
                endpos = {
                    x = PDB[UIN].copy.keepPos.endpos.x,
                    y = PDB[UIN].copy.keepPos.endpos.y,
                    z = PDB[UIN].copy.keepPos.endpos.z,
                },
            },
            vector = {
                x = PDB[UIN].copy.vector.x,
                y = PDB[UIN].copy.vector.y,
                z = PDB[UIN].copy.vector.z,
            },
            direction = {
                x = PDB[UIN].copy.direction.x,
                y = PDB[UIN].copy.direction.y,
                z = PDB[UIN].copy.direction.z,
            },
            areadata = {},
        }

        --开data跑循环 一层套一层 像俄罗斯套娃
        for x = 0, PAT.data[patId].vector.x, PAT.data[patId].direction.x
        do
            PAT.data[patId].areadata[x] = {}
            for y = 0, PAT.data[patId].vector.y, PAT.data[patId].direction.y
            do
                PAT.data[patId].areadata[x][y] ={}
                for z = 0, PAT.data[patId].vector.z, PAT.data[patId].direction.z
                do
                    PAT.data[patId].areadata[x][y][z] ={}
                end
            end
        end
        --把数据搬过去
        for x = 0, PAT.data[patId].vector.x, PAT.data[patId].direction.x
        do
            for y = 0, PAT.data[patId].vector.y, PAT.data[patId].direction.y
            do
                for z = 0, PAT.data[patId].vector.z, PAT.data[patId].direction.z
                do
                    if(PDB[UIN].copy.areadata[x][y][z].id)
                    then
                        PAT.data[patId].areadata[x][y][z] ={
                            id = PDB[UIN].copy.areadata[x][y][z].id,
                            data = PDB[UIN].copy.areadata[x][y][z].data,
                        }
                    end
                end
            end
        end

        --记入pat数
        PAT.count = PAT.count + 1
        --返回id和名字
        return PAT.count, PAT.data[PAT.count].name
    else --没有 没有 没有 通过
        msg(CL.tip.pat.copyToPatNoData[Lang],UIN)
        --没有返回值
    end
end

--在玩家当前位置粘贴pat 根据PDB[UIN].copy.way选择粘贴的方式 使用复苏法杖后运行 参数是玩家的迷你号 
local function pastePat(UIN)
    if(PDB[UIN].pattern.nowPatId == -1)--如果没有指定patid 
    then--输出没有指定的消息
        msg(CL.tip.pat.pasteNoSpec[Lang],UIN)
    else --有指定的pat 就粘贴
        --获取玩家位置
        local result,px,py,pz=Actor:getPosition(UIN)
        --将这次粘贴的位置保存到copy中 备撤销用
        PDB[UIN].pattern.LastPastePatPos = {x=px,y=py,z=pz}
        --提取PatId
        local patId = PDB[UIN].pattern.nowPatId
        --提取数据
        for x = 0, PAT.data[patId].vector.x, PAT.data[patId].direction.x
        do
            for y = 0, PAT.data[patId].vector.y, PAT.data[patId].direction.y
            do
                for z = 0, PAT.data[patId].vector.z, PAT.data[patId].direction.z
                do
                    if(PAT.data[patId].areadata[x][y][z].id)
                    then
                        local result,BeforeId = Block:getBlockID(px+x, py+y, pz+z)
                        if(PDB[UIN].copy.way == 1) --1.无视光束线粘贴(默认)
                        then
                            if(BeforeId == 0 or BeforeId == 351) --空气或光束线
                            then
                                Block:setBlockAll(px+x, py+y, pz+z, PAT.data[patId].areadata[x][y][z].id, PAT.data[patId].areadata[x][y][z].data)
                            end
                        elseif(PDB[UIN].copy.way == 2)-- 2.无视除电路外任何方块粘贴
                        then
                            if(not((BeforeId>=352 and BeforeId<=374) or (BeforeId==415) or (BeforeId>=690 and BeforeId<=722))) --排除电路元件和音乐方块
                            then
                                Block:setBlockAll(px+x, py+y, pz+z, PAT.data[patId].areadata[x][y][z].id, PAT.data[patId].areadata[x][y][z].data)
                            end
                        elseif(PDB[UIN].copy.way == 3)-- 3.无视任何方块粘贴 
                        then
                            Block:setBlockAll(px+x, py+y, pz+z, PAT.data[patId].areadata[x][y][z].id, PAT.data[patId].areadata[x][y][z].data)
                        end
                    end
                end
            end
        end
        --记录id 输出提示
        PDB[UIN].pattern.lastPasPatId = patId
        msg(string.format(CL.tip.pat.pastePatSuc[Lang], patId), UIN)
    end
    return 0
end

--撤销粘贴的pat 参数是玩家的迷你号
local function revokePat(UIN)
    --上次粘贴的id
    local lastPatId = PDB[UIN].pattern.lastPasPatId
    if(lastPatId ~= -1) --有粘贴过东西
    then
        --上次粘贴的位置
        local px, py, pz = PDB[UIN].pattern.LastPastePatPos.x, PDB[UIN].pattern.LastPastePatPos.y, PDB[UIN].pattern.LastPastePatPos.z
        for x = 0, PAT.data[lastPatId].vector.x, PAT.data[lastPatId].direction.x
        do
            for y = 0, PAT.data[lastPatId].vector.y, PAT.data[lastPatId].direction.y
            do
                for z = 0, PAT.data[lastPatId].vector.z, PAT.data[lastPatId].direction.z
                do
                    if(PAT.data[lastPatId].areadata[x][y][z].id) --对比id和data 进行清除操作
                    then
                        local result,BeforeId = Block:getBlockID(px+x, py+y, pz+z)
                        if(BeforeId == PAT.data[lastPatId].areadata[x][y][z].id)
                        then
                            local result,data=Block:getBlockData(px+x, py+y, pz+z)
                            if(data == PAT.data[lastPatId].areadata[x][y][z].data)
                            then
                                Block:destroyBlock(px+x, py+y, pz+z, false)
                            end
                        end
                    end
                end
            end
        end
        msg(CL.tip.pat.revokeSuc[Lang], UIN)
    end
    return 0
end

--对玩家显示音调列表 参数是玩家的迷你号
local function displayToneList(UIN)
    for i = 1, 12
    do
        msg(string.format(CL.tip.globalSetTip.toneDisplayTemplate[Lang], i, pitchList[i].name, pitchList[i].intro), UIN)
    end
end

--对玩家显示设置数据 参数是玩家的迷你号
local function displaySettings(UIN)
    local str = "awa"--先预设一个字符串
    if(isFold) --制作提示消息
    then --如果是折轨
        str = string.format(CL.tip.globalSetTip.setDisFold[Lang], pitchList[pitch].name, pitchList[pitch].intro, fold.offset, fold.period, fold.leftTrackInPeriod)
    else --直轨的
        str = string.format(CL.tip.globalSetTip.setDisTem[Lang], pitchList[pitch].name, pitchList[pitch].intro, offset.x, offset.y, offset.z)
    end
    --输出
    msg(str, UIN)
end

--对玩家显示道具介绍 参数是玩家的迷你号
local function itemInt(UIN)
    Trigger:wait(0.1)
    for i = 1, #itemIntro[Lang]
    do
        Chat:sendSystemMsg(itemIntro[Lang][i], UIN) --逐条输出
        if(i>=3)
        then
            Trigger:wait((#itemIntro[Lang][i]*0.03)) --根据字数设定延迟
        end
    end
    return 0
end

--格式化小数的函数 参数是一个num 返回值是string
local function formatDecimal(number)
    if(number % 1 == 0) --如果它是整数 那就直接返回 不处理
    then
        return tostring(number)
    end
    local decimalPlaces = tostring(number):match('%.?(%d*)$') --截取它的有效小数
    local formattedNumber = string.format("%." .. #decimalPlaces .. "f", number)
    return formattedNumber
end

--向0取整的函数 用来处理玩家坐标
local function roundTo0(num)
    local integerPart = 0 --预定义一个变量
    if(num >= 0)
    then
        integerPart = math.floor(num)
    else
        integerPart = math.ceil(num)
    end
    return integerPart
end

-- 检查一个数值是否存在于表中 参数是那个表名和要查找的值 返回一个布尔值
local function containsValue(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

--判断离玩家最近的向左的轨的距离的函数 参数是玩家的关键坐标 返回值是玩家与最近的向左的轨的距离
local function getDistance(playerPos)
    --玩家的关键坐标对周期取模
    local playerPosInPeriod = playerPos % fold.period

    --顺时针逆时针分别求玩家与左轨的距离
    local clockwiseDistance = math.abs(playerPosInPeriod - fold.leftTrackInPeriod)
    local counterclockwiseDistance = fold.period - clockwiseDistance
    --返回一个最小的
    return math.min(clockwiseDistance, counterclockwiseDistance)
end

--对玩家做一个偏移 参数是玩家的迷你号
local function doOffset(UIN)
    local result,x,y,z=Actor:getPosition(UIN)--获取玩家位置
    if(isFold)
    then--折轨的情况
        local distance = 0 --在这定义一个变量 放距离
        if(fold.axis == "Z")--判断玩家与关键轴的距离
        then--z轴
            distance = getDistance(z)
        else--x轴
            distance = getDistance(x)
        end

        if(distance <= fold.distance)--看看玩家在哪个区间
        then--向左
            Actor:setPosition(UIN, x + foldPara[fold.axis][fold.direction].left.x * fold.offset, y, z+foldPara[fold.axis][fold.direction].left.z * fold.offset)
        else--向右
            Actor:setPosition(UIN, x + foldPara[fold.axis][fold.direction].right.x * fold.offset, y, z+foldPara[fold.axis][fold.direction].right.z * fold.offset)
        end
    else--直轨的情况 直接从全局的offset中抽提数据 这个简单awa
        --位置偏移
        Actor:setPosition(UIN, x+offset.x, y+offset.y, z+offset.z)
        --结束函数
        return 0
    end
end

--根据玩家锚定的起点和终点 检索其中的方块记录在表中 参数是玩家的迷你号和一个布尔值 代表是否只记录音乐方块
local function createAreaBlockDataList(UIN, isOnlyMusBlo)
    --先清空两个等下要用的表 确保其中没有残留的数据
    PDB[UIN].areaBlockData = {}
    PDB[UIN].areaBlockDataIndex = {}

    --取区域的端点值
    local x1, x2, y1, y2, z1, z2 = 0, 0, 0, 0, 0, 0 --定义变量
    if(isOnlyMusBlo)
    then --玩家用雷电法杖框选的音乐区域
        x1, x2 = math.min(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.endpos.x), math.max(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.endpos.x)
        y1, y2 = math.min(PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.endpos.y), math.max(PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.endpos.y)
        z1, z2 = math.min(PDB[UIN].copy.pos.strpos.z, PDB[UIN].copy.pos.endpos.z), math.max(PDB[UIN].copy.pos.strpos.z, PDB[UIN].copy.pos.endpos.z)
    else --全类型方块区域
        x1, x2 = math.min(PDB[UIN].areaPAT.pos.strpos.x, PDB[UIN].areaPAT.pos.endpos.x), math.max(PDB[UIN].areaPAT.pos.strpos.x, PDB[UIN].areaPAT.pos.endpos.x)
        y1, y2 = math.min(PDB[UIN].areaPAT.pos.strpos.y, PDB[UIN].areaPAT.pos.endpos.y), math.max(PDB[UIN].areaPAT.pos.strpos.y, PDB[UIN].areaPAT.pos.endpos.y)
        z1, z2 = math.min(PDB[UIN].areaPAT.pos.strpos.z, PDB[UIN].areaPAT.pos.endpos.z), math.max(PDB[UIN].areaPAT.pos.strpos.z, PDB[UIN].areaPAT.pos.endpos.z)
    end

    if(isOnlyMusBlo)--只看音乐方块
    then
        for x = x1, x2
        do
            for y = y1, y2
            do
                for z = z1, z2
                do
                    --获取方块id
                    local result, id = Block:getBlockID(x, y, z)
                    if(690 <= id and id <= 695)--如果是音乐方块
                    then--检查表中是否有索引 并注入数据
                        if(not PDB[UIN].areaBlockData[id])
                        then --如果没有这个方块的索引 就新增一个
                            PDB[UIN].areaBlockData[id] = {}
                        end
                        --获取它的data 并检测是否在表中
                        local result, data = Block:getBlockData(x, y, z)
                        if(not containsValue(PDB[UIN].areaBlockData[id], data))
                        then --如果没有 就新增一个
                            table.insert(PDB[UIN].areaBlockData[id], data)
                        end
                    end
                end
            end
        end
    else --这就是录入所有方块的数据了 我为什么不把isOnlyMusBlo条件判断写到循环内呢 因为循环内部执行的东西越少越好 不要弄一次就是一个条件判断 要注意性能的消耗
        for x = x1, x2
        do
            for y = y1, y2
            do
                for z = z1, z2
                do
                    --获取方块id
                    local result, id = Block:getBlockID(x, y, z)
                    --检查表中是否有索引 并注入数据
                    if(not PDB[UIN].areaBlockData[id])
                    then --如果没有这个方块的索引 就新增一个
                        PDB[UIN].areaBlockData[id] = {}
                    end
                    --获取它的data 并检测是否在表中
                    local result, data = Block:getBlockData(x, y, z)
                    if(not containsValue(PDB[UIN].areaBlockData[id], data))
                    then --如果没有 就新增一个
                        table.insert(PDB[UIN].areaBlockData[id], data)
                    end
                end
            end
        end
    end
    --录入数据之后开始整理计算 输出表中的玩意
    local index = 1 --表的索引
    for bloId, dataList in pairs(PDB[UIN].areaBlockData)
    do--这里的每个val都是对应方块的data表
        for i = 1, #dataList
        do --对每个方块的每种data创建一个索引
            PDB[UIN].areaBlockDataIndex[index] = {
                id = bloId,
                data = dataList[i],
            }
            --制作并输出消息
            local result, name = Item:getItemName(bloId)
            local str = string.format(CL.tip.areaOperations.formatMsg,index, name, bloId, dataList[i])
            msg(str, UIN)
            index = index + 1 --索引自加
        end
    end
    return 0
end

--整理计算完成后 对区域方块进行替换的函数 参数是玩家迷你号 玩家在areaBlockDataIndex中指定的索引 想要替换成的方块id 和data 还有是否只弄音乐方块
local function areaBlockReplace(UIN, targetIndex, afterId, afterData, isOnlyMusBlo)
    --取区域的端点值
    local x1, x2, y1, y2, z1, z2 = 0, 0, 0, 0, 0, 0 --定义变量
    if(isOnlyMusBlo)
    then --玩家用雷电法杖框选的音乐区域
        x1, x2 = math.min(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.endpos.x), math.max(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.endpos.x)
        y1, y2 = math.min(PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.endpos.y), math.max(PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.endpos.y)
        z1, z2 = math.min(PDB[UIN].copy.pos.strpos.z, PDB[UIN].copy.pos.endpos.z), math.max(PDB[UIN].copy.pos.strpos.z, PDB[UIN].copy.pos.endpos.z)
    else --全类型方块区域
        x1, x2 = math.min(PDB[UIN].areaPAT.pos.strpos.x, PDB[UIN].areaPAT.pos.endpos.x), math.max(PDB[UIN].areaPAT.pos.strpos.x, PDB[UIN].areaPAT.pos.endpos.x)
        y1, y2 = math.min(PDB[UIN].areaPAT.pos.strpos.y, PDB[UIN].areaPAT.pos.endpos.y), math.max(PDB[UIN].areaPAT.pos.strpos.y, PDB[UIN].areaPAT.pos.endpos.y)
        z1, z2 = math.min(PDB[UIN].areaPAT.pos.strpos.z, PDB[UIN].areaPAT.pos.endpos.z), math.max(PDB[UIN].areaPAT.pos.strpos.z, PDB[UIN].areaPAT.pos.endpos.z)
    end

    for x = x1, x2
    do
        for y = y1, y2
        do
            for z = z1, z2
            do
                local result, id = Block:getBlockID(x, y, z) --获取方块id
                --如果方块id等于玩家指定的那个索引
                if(id == PDB[UIN].areaBlockDataIndex[targetIndex].id)
                then --再看看它的data是不是玩家所指定的
                    local result, data = Block:getBlockData(x, y, z)
                    if(data == PDB[UIN].areaBlockDataIndex[targetIndex].data)
                    then --如果是 那就替换成玩家指定的方块类型和data
                        Block:setBlockAll(x, y, z, afterId, afterData)
                    end
                end
            end
        end
    end
    --输出成功的提示
    msg(CL.tip.areaOperations.replaceSuc[Lang], UIN)
    return 0
end

--判断某数值是否在一个由两个数值组成的区间中 参数是区间端点两个数 待检测的那个数 区间是否是闭区间(包含端点) 返回值是一个布尔值
local function isNumInRange(ran1, ran2, num, isCloseInterval)
    --取端点值
    local num1 = math.min(ran1, ran2)
    local num2 = math.max(ran1, ran2)
    if(isCloseInterval)
    then --闭区间 包含端点
        if(num1 <= num and num <= num2)
        then
            return true
        end
        return false
    else --开区间
        if(num1 < num and num < num2)
        then
            return true
        end
        return false
    end
end

--对玩家的音乐选区进行移调 参数是玩家的迷你号 移多少个半音（-12 ~ 12）
local function transpose(UIN, semitoneNum)
    --检查它的参数
    if(not (-12 <= semitoneNum and semitoneNum <= 12))
    then --不在合法范围内 输入错误
        msg(CL.tip.transpose.inputErr[Lang], UIN)
        return 1001 --返回错误码
    end
    --取区域的端点值
    local x1, x2, y1, y2, z1, z2 = 0, 0, 0, 0, 0, 0 --定义变量
    x1, x2 = math.min(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.endpos.x), math.max(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.endpos.x)
    y1, y2 = math.min(PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.endpos.y), math.max(PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.endpos.y)
    z1, z2 = math.min(PDB[UIN].copy.pos.strpos.z, PDB[UIN].copy.pos.endpos.z), math.max(PDB[UIN].copy.pos.strpos.z, PDB[UIN].copy.pos.endpos.z)
    for x = x1, x2
    do
        for y = y1, y2
        do
            for z = z1, z2
            do
                local result, id = Block:getBlockID(x, y, z) --获取方块id
                --如果方块是音调方块
                if(690 <= id and id <= 692)
                then --再把它的data扲出来
                    local result, data = Block:getBlockData(x, y, z)
                    local afterId = id --移调后的id
                    --然后开始计算它移调后的id和data
                    local afterData = data + semitoneNum
                    if(afterData >= 12)
                    then --如果data在移调后超过最大值
                        afterId = afterId + 1
                        afterData = afterData - 12
                    elseif(afterData < 0)
                    then --如果data在移调后小于最小值
                        afterId = afterId - 1
                        afterData = afterData + 12
                    end

                    --看看移调后的音调方块id是否在可置区间内 如果不在范围内 使用倍高音或倍低音
                    if(afterId < 690)
                    then --使用倍低音 电子(694)0
                        --在上面放上对应的乐器方块
                        Block:setBlockAll(x, y + 1, z, 694, 0)
                        afterId = 690 --将音调方块置于可用区间
                    elseif(afterId > 692)
                    then --使用倍高音 综合(695)7
                        Block:setBlockAll(x, y + 1, z, 695, 7)
                        afterId = 692
                    end
                    --放置移调后的音调方块
                    Block:setBlockAll(x, y, z, afterId, afterData)
                end
            end
        end
    end
    --输出提示
    msg(CL.tip.transpose.transSuc[Lang], UIN)
    return 0
end

--删除区域内指定id和data的方块的函数 参数是起点终点的tab 形如{x = 1, y = 2, z = 3} 目标方块的id和data
local function delBlockInAreaByIdData(strposTab, endposTab, targetId, targetData)
    --取区域端点值
    local x1, x2 = math.min(strposTab.x, endposTab.x), math.max(strposTab.x, endposTab.x)
    local y1, y2 = math.min(strposTab.y, endposTab.y), math.max(strposTab.y, endposTab.y)
    local z1, z2 = math.min(strposTab.z, endposTab.z), math.max(strposTab.z, endposTab.z)
    for x = x1, x2
    do
        for y = y1, y2
        do
            for z = z1, z2
            do
                local result, id = Block:getBlockID(x, y, z) --获取方块id
                --如果方块id正确
                if(id == targetId)
                then --再把它的data扲出来
                    local result, data = Block:getBlockData(x, y, z)
                    if(data == targetData)
                    then --如果data正确 就删掉这个方块
                        Block:destroyBlock(x, y, z, false)
                    end
                end
            end
        end
    end
end

--判断方块是不是音乐方块 参数是方块的id 返回值是一个布尔值
local function isMusicBlo(id)
    if(690 <= id and id <= 699)
    then
        return true
    end
    return false
end

--清空一个区域内的所有音乐方块 参数是起点终点的tab 形如{x = 1, y = 2, z = 3}
local function clearAreaMusicBlock(strposTab, endposTab)
    --取区域端点值
    local x1, x2 = math.min(strposTab.x, endposTab.x), math.max(strposTab.x, endposTab.x)
    local y1, y2 = math.min(strposTab.y, endposTab.y), math.max(strposTab.y, endposTab.y)
    local z1, z2 = math.min(strposTab.z, endposTab.z), math.max(strposTab.z, endposTab.z)
    for x = x1, x2
    do
        for y = y1, y2
        do
            for z = z1, z2
            do
                local result, id = Block:getBlockID(x, y, z) --获取方块id
                --如果方块是音乐方块 就破坏掉
                if(isMusicBlo(id))
                then
                    Block:destroyBlock(x, y, z, false)
                end
            end
        end
    end
end

--判断字符串是不是以/开头的指令 参数是字符串 返回值是一个布尔值
local function isCommand(input)
    return input:sub(1, 1) == "/"
end

---------------------- 事件关联动作定义 ----------------------
--玩家进入游戏时
local function Game_AnyPlayer_EnterGame(event)
    local UIN = event.eventobjid --我不想变量名称太长

    --让玩家飞行
    Player:changPlayerMoveType(UIN,1)

    --检测并给玩家添加道具
    for k ,v in pairs(Itemid_List)
    do
        local result=Backpack:hasItemByBackpackBar(UIN,1,v)
        local result2=Backpack:hasItemByBackpackBar(UIN,2,v)
        if(result2==1001 and result==1001)
        then
            Player:gainItems(UIN,v,1,1)
        end
    end

    --intro
    for i = 0 ,#intro[Lang]
    do
        msg(intro[Lang][i],UIN)
    end

    --将玩家拉入清单
    PDB[UIN]={
        switch = false,
        DrumState = false,
        Brush = {
            state = false,
            size = 2,
        },
        copy = {
            way = 1,
            pos = {
                strpos = {},
                endpos = {},
            },
            keepPos = {
                strpos = {},
                endpos = {},
            },
            vector = {},
            direction = {},
            areadata = {},
            LastPastePos = {},
        },
        pattern = {
            rename = false,
            renameId = -1,
            nowPatId = -1,
            LastPastePatPos = {},
            lastPasPatId = -1,
        },
        attr = {
            force = 10,
            speed = false,
            size = false,
            setForce = false,
        },
        areaBlockData = {},
        areaBlockDataIndex = {},
        areaPAT = {
            rename = false,
            renameId = -1,
            nowPatId = -1,
            LastPastePatPos = {},
            lastPasPatId = -1,
            way = 1,
            pos = {
                strpos = {},
                endpos = {},
            },
            LastPastePos = {},
        },
    }
    return 0
end

--玩家离开游戏时 将玩家移出点击次数列表
local function Game_AnyPlayer_LeaveGame(event)
    PDB[event.eventobjid]=nil
end

--玩家输入字符串时 ...
local function PlayerNewInputContent(event)
    local UIN = event.eventobjid --我不想变量名称太长

    ---------------------- 通用功能 ----------------------

    --输入id（不分大小写） 输出玩家当前手持道具的信息
    local st = string.lower(event.content)
    if(st == "id")
    then
        --获取玩家手持道具id
        local result, id = Player:getCurToolID(UIN)
        local result, name = Item:getItemName(id) --通过id获取道具名称
        --格式化提示字符串
        local str = string.format(CL.tip.item.getCurToolID[Lang], name, id)
        msg(str, UIN)--对当前玩家输出
    end

    if(event.content==CL.order.clearMIData[Lang])--清除对应玩家的数据
    then
        PDB[UIN]['block_id']=nil
        PDB[UIN]['click_num']=nil
        PDB[UIN]['z_bloid']=nil
        PDB[UIN]['z_num']=nil
        PDB[UIN]['switch']=false
        Trigger:wait(0.1)
        msg(CL.tip.MI.clearMIDataSuc[Lang], UIN)
        return 0
    end

    local result,CurToolid=Player:getCurToolID(UIN)
    --如果是收割者 操作
    if(CurToolid == 12009)
    then
        local num = tonumber(event.content)
        local ck = globalSetState.chooseKey
        local so = globalSetState.setOffset
        local sf = globalSetState.setFold
        local cfp = globalSetState.chooseFoldPara
        local slp = globalSetState.setLeftPos
        local srp = globalSetState.setRightPos
        local sfo = globalSetState.setFoldOffset

        if(sf)--配置折轨的情况
        then
            if(cfp) --选方向
            then
                if(0 <= num and num <= 4)
                then --从索引表中注入数据
                    fold.axis = foldList[num].axis
                    fold.direction = foldList[num].direction

                    --改变开关状态
                    globalSetState.chooseFoldPara = false
                    globalSetState.setLeftPos = true

                    --输出下一条的提示
                    msg(CL.tip.fold.chooseDirSuc[Lang], UIN)
                    msg(CL.tip.fold.trackTip[Lang], UIN)
                    msg(CL.tip.fold.trackTip2[Lang], UIN)
                    --结束函数
                    return 0
                end
            elseif(slp) --定左轨
            then
                local result,x,y,z=Actor:getPosition(UIN)--获取玩家位置
                x = roundTo0(x) --取整
                z = roundTo0(z)
                if(event.content == "L" or event.content == "l")
                then --配置向左的
                    if(fold.axis == "Z") --根据地图方向确定关键坐标
                    then
                        fold.leftTrackKeyPos = z
                    else
                        fold.leftTrackKeyPos = x
                    end
                    --开关
                    globalSetState.setLeftPos = false
                    globalSetState.setRightPos = true
                    --输出提示
                    msg(CL.tip.fold.trackTip3[Lang], UIN)
                    --结束函数
                    return 0
                end
            elseif(srp) --定右轨
            then
                local result,x,y,z=Actor:getPosition(UIN)--获取玩家位置
                x = roundTo0(x) --取整
                z = roundTo0(z)
                if(event.content == "R" or event.content == "r")
                then --配置向右的
                    if(fold.axis == "Z") --根据地图方向确定关键坐标
                    then
                        fold.rightTrackKeyPos = z
                    else
                        fold.rightTrackKeyPos = x
                    end
                end
                --开关
                globalSetState.setRightPos = false
                globalSetState.setFoldOffset = true
                --输出提示
                msg(CL.tip.fold.trackTip4[Lang], UIN)
                --做数值计算 填表
                local dis = math.abs(fold.leftTrackKeyPos - fold.rightTrackKeyPos)--轨距
                fold.period = 2 * dis --周期
                fold.distance = dis / 2 --判断玩家区间用的值
                fold.leftTrackInPeriod = fold.leftTrackKeyPos % fold.period ----向左的轨在周期中的位置
                --结束函数
                return 0
            elseif(sfo) --设偏移量
            then
                if(num) --如果玩家输入的是数字
                then
                    fold.offset = num --注入数据
                    --开关 设置状态全部关掉 并打开全局折轨状态
                    globalSetState.setFoldOffset = false
                    globalSetState.setFold = false
                    isFold = true

                    --输出提示
                    msg(CL.tip.fold.foldSuc[Lang], UIN)
                end
            end
        end

        if(num)--如果玩家输入的是数字
        then
            if(ck == false and so == false and sf == false and cfp == false and slp == false and srp == false and sfo == false)
            then --单纯指令的情况
                if(num == 1) --使用说明
                then
                    user(UIN)
                    return 0
                elseif(num == 2) --道具介绍
                then
                    itemInt(UIN)
                    return 0
                elseif(num == 3)--切换语言
                then
                    if(Lang == 1)
                    then
                        Lang = 2 --改变语言
                    elseif(Lang == 2)
                    then
                        Lang = 1 --改变语言
                    end
                    --输出当前版本的intro
                    for i = 0 ,#intro[Lang]
                        do
                            msg(intro[Lang][i],UIN)
                        end
                    return 0
                elseif(num == 4)--飞
                then
                    local result = Player:changPlayerMoveType(UIN,1)
                    return 0
                elseif(num == 5)--落
                then
                    local result = Player:changPlayerMoveType(UIN,0)
                    return 0
                elseif(num == 6)--设置调性(先显示调性列表)
                then
                    displayToneList(UIN)
                    msg(CL.tip.globalSetTip.setPitchTip[Lang], UIN)
                    globalSetState.chooseKey = true
                    return 0
                elseif(num == 7)--设置位置偏移
                then
                    msg(CL.tip.globalSetTip.setOffsetTip[Lang], UIN)
                    globalSetState.setOffset = true
                    return 0
                elseif(num == 8)--查看当前设置
                then
                    displaySettings(UIN)
                    return 0
                elseif(num == 9) --设置折轨
                then
                    --先输出提示
                    msg(CL.tip.fold.tip1[Lang], UIN)
                    msg(CL.tip.fold.tip2[Lang], UIN)
                    msg(CL.tip.fold.tip3[Lang], UIN)
                    msg(CL.tip.fold.tip4[Lang], UIN)

                    --打开状态 以接受输入
                    globalSetState.setFold = true
                    globalSetState.chooseFoldPara = true

                    Trigger:wait(5) --等待一下

                    --输出方向列表供玩家选择
                    for key, value in pairs(foldPara)
                    do
                        for k, v in pairs(value) do
                            msg(tostring(v.ind) .. ". " .. v.direction[Lang], UIN)
                        end
                    end
                end
            end

            if(ck)--设置调性的情况
            then
                if(num >= 1 and num <=12)
                then
                    pitch = num --设置调性
                    local str = string.format(CL.tip.globalSetTip.setPitchTipSuc[Lang], pitchList[pitch].name)
                    msg(str, UIN)--输出提示
                end
                globalSetState.chooseKey = false --关掉 关掉 一定要关掉 关掉网络游戏！！！
                return 0
            end
        end

        if(so) --设置直轨位置偏移的情况
        then
            local input = event.content
            local x, y, z = input:match("(-?%d+)%s+(-?%d+)%s+(-?%d+)")
            if (x and y and z)
            then --设置
                offset.x = tonumber(x)
                offset.y = tonumber(y)
                offset.z = tonumber(z)
                local str = string.format(CL.tip.globalSetTip.setOffsetSuc[Lang], x, y, z)
                msg(str, UIN)
                globalSetState.setOffset = false --记得关掉
                isFold = false --如果设置了直轨 就把折轨关掉
                return 0
            else --输入格式不正确 不关掉 玩家可以再次输入
                msg(CL.tip.globalSetTip.setOffsetErrInp[Lang], UIN)
            end
            return 0
        end
    end

    --星铜钻头的情况
    if(CurToolid == 11016)
    then
        local num = tonumber(event.content)
        if(event.content == "a" or event.content == "A") --输出提示 改变状态(打开一个关掉两个) 准备接收玩家的输入
        then
            msg(CL.tip.attr.impNum[Lang], UIN)
            PDB[UIN].attr.speed = true
            PDB[UIN].attr.size = false
            PDB[UIN].attr.setForce = false
            return 0
        elseif(event.content == "b" or event.content == "B")
        then
            msg(CL.tip.attr.impNum[Lang], UIN)
            PDB[UIN].attr.speed = false
            PDB[UIN].attr.size = true
            PDB[UIN].attr.setForce = false
            return 0
        elseif(event.content == "c" or event.content == "C")
        then
            msg(CL.tip.attr.impNum[Lang], UIN)
            PDB[UIN].attr.speed = false
            PDB[UIN].attr.size = false
            PDB[UIN].attr.setForce = true
            return 0
        end

        if(num)--输入是数字的情况
        then
            if(PDB[UIN].attr.speed) --设置速度
            then
                if(num < 0) --判断输入是否合法
                then --不合法 输出提示
                    msg(CL.tip.attr.impNumIllegal[Lang], UIN)
                else --合法 更改玩家的移动速度和奔跑速度
                    Player:setAttr(UIN, PLAYERATTR.WALK_SPEED, num)
                    Player:setAttr(UIN, PLAYERATTR.RUN_SPEED, num)
                    local str = string.format(CL.tip.attr.changeSpeedSuc[Lang], event.content) --制作消息
                    msg(str, UIN) --对玩家弹出消息
                end
            elseif(PDB[UIN].attr.size)--设置大小
            then
                if(num <= 0) --判断输入是否合法
                then --不合法 输出提示
                    msg(CL.tip.attr.impNumIllegal[Lang], UIN)
                else --合法 修改模型大小
                    Player:setAttr(UIN, PLAYERATTR.DIMENSION, num)
                    local str = string.format(CL.tip.attr.changeSizeSuc[Lang], event.content) --制作消息
                    msg(str, UIN) --对玩家弹出消息
                end
            elseif(PDB[UIN].attr.setForce)--设置力度
            then
                if(num < 0) --判断输入是否合法
                then --不合法 输出提示
                    msg(CL.tip.attr.impNumIllegal[Lang], UIN)
                else --合法
                    PDB[UIN].attr.force = num --更改数值
                    local str = string.format(CL.tip.attr.changeForceSuc[Lang], event.content) --制作消息
                    msg(str, UIN) --对玩家弹出消息
                end
            end
            return 0
        end
    else--其他道具的话 就把那三个状态关掉 不结束这个函数
        PDB[UIN].attr.speed = false
        PDB[UIN].attr.size = false
        PDB[UIN].attr.setForce = false
    end

    --巨人核心和推拉机械臂
    if(CurToolid == 1059 or CurToolid == 368)
    then
        local num = tonumber(event.content)
        if(num)--如果玩家输入的是一个数
        then
            if(0 <= num and num <= 5) --判断玩家输入是否合法
            then --在范围内就生成awa
                local result, x, y, z = Actor:getPosition(UIN) --获取玩家位置
                Block:setBlockAll(x, y, z, CurToolid, num) --生成方块
                if(CurToolid == 368)
                then--如果是推拉机械臂 要附带一个花纹电石块
                    Block:placeBlock(1104, x + robotArmDir[num].x, y + robotArmDir[num].y, z + robotArmDir[num].z, 0)
                end
            end
        end
    end
    ---------------------- 区域方块复制、操作与pat ----------------------
    --手持极寒域法杖 执行撤销操作/ 输入数字 改变copy.way(粘贴的方式)
    if(CurToolid == 11668 )
    then
        --执行撤销操作
        if(event.content == CL.ORDER.CANCEL[Lang])
        then
            if(PDB[UIN].copy.LastPastePos.x)
            then
                msg(CL.tip.copy.startUndo[Lang],UIN)
                ctrl_z(UIN)
            end
            return 0
        end

        local num = tonumber(event.content)
        if(num>= 1 and num<= 3 )
        then
            PDB[UIN].copy.way = num
            msg(string.format(CL.tip.copy.changePasWay[Lang], num), UIN)
        end
        return 0
    end

    --如是复苏法杖 pattern操作
    if(CurToolid == 11584)
    then
        --首先考虑接受字符串为pat重命名的情况
        if(PDB[UIN].pattern.rename and (PDB[UIN].pattern.renameId ~= -1))
        then
            local name = event.content
            local id = PDB[UIN].pattern.renameId
            local preName = PAT.data[id].name --留下以前的名字
            PAT.data[id].name = name --重命名的操作
            msg(string.format(CL.tip.pat.renameSuc[Lang], preName, PAT.data[id].name),UIN)
            --复原
            PDB[UIN].pattern.rename = false
            PDB[UIN].pattern.renameId = -1
            return 0
        end

        --撤销的操作
        if(event.content == CL.order.cancel[Lang])
        then
            revokePat(UIN)
            return 0
        end

        if(event.content == "a" or event.content == "A")
        then --显示pat列表
            displayPatList(UIN)
            return 0
        end

        if(event.content == "b" or event.content == "B")
        then --录入当前数据作为pat
            local id, name = copyToPat(UIN)
            if(id) --如果有返回(执行成功)
            then
                msg(string.format(CL.tip.pat.copyToPatSuc[Lang], id, name),UIN)
            else --执行失败
                msg(CL.tip.pat.copyToPatFail[Lang],UIN)
            end
            return 0
        end

        if(event.content == "c" or event.content == "C")
        then --显示pat列表并重命名指定pat
            displayPatList(UIN)
            PDB[UIN].pattern.rename = true
            if(PAT.count ~= 0) --有数据
            then
                msg(CL.tip.pat.renameTip[Lang],UIN)
            end
        end

        local num = tonumber(event.content)
        if(num) --如果玩家输入的是数字
        then
            --判断是不是重命名的情况 和哪种情况
            if(PDB[UIN].pattern.rename) --如果玩家的rename状态是开
            then
                if(PDB[UIN].pattern.renameId == -1)
                then --没有要重命名的pat 接收这个数作为要重命名的pat
                    PDB[UIN].pattern.renameId = num
                    msg(string.format(CL.tip.pat.renameTip2[Lang], num),UIN)
                    return 0
                end
            else --不是重命名 就是玩家选择想粘贴的id 录入就绪的id 输出消息
                if(num > 0) --保险起见
                then
                    PDB[UIN].pattern.nowPatId = num
                    msg(string.format(CL.tip.pat.specPatSuc[Lang], PDB[UIN].pattern.nowPatId), UIN)
                    return 0
                end
            end
        end
        return 0
    end

    --如果是雷电法杖且玩家持有选区(终点)信息 看看玩家输入的是不是指令
    if((CurToolid == 11582) and (type(PDB[UIN].copy.pos.endpos.x) == "number"))
    then
        if(isCommand(event.content)) --如果是指令
        then --判断对应的指令 按规则截取它们的参数 执行对应的函数
            local pattern = "/(%a+)%s*()" --匹配它的指令(string) 和参数开头的位置(num)
            local command, strnum = string.match(event.content, pattern)
            
            --如果能找到参数列表 就从对应的位置开始截取它的参数
            local arguments = "awa" --定义变量罢了 值是乱写的
            if(strnum)
            then
                arguments = string.sub(event.content, strnum)
            else --没有参数列表 就删掉这个变量
                arguments = nil
            end

            if(command == "trans") --移调 nsemitoneNum
            then
                local num = tonumber(arguments) --只有一个参数 那么直接转成数值就行了
                transpose(UIN, num) --移调
            elseif(command == "index") --创建索引 无参数
            then--这一定是只看音乐方块 所以函数的第二个参数是true
                createAreaBlockDataList(UIN, true)
            elseif(command == "replace") --替换方块 index id data
            then
                --截取需要的三个参数
                local index, id, data = string.match(arguments, "(%d+)%s+(%d+)%s+(%d+)")
                --替换对应的方块 只看音乐方块
                areaBlockReplace(UIN, index, id, data, true)
            elseif(command == "del") --删除方块 index
            then
                local index = tonumber(arguments) --只有一个参数
                local tarId, tarData = PDB[UIN].areaBlockDataIndex[index].id, PDB[UIN].areaBlockDataIndex[index].data
                delBlockInAreaByIdData(PDB[UIN].copy.pos.strpos, PDB[UIN].copy.pos.endpos, tarId, tarData)
                --输出提示
                msg(CL.tip.transpose.delSuc[Lang], UIN)
            elseif(command == "clear") --清空区域
            then
                clearAreaMusicBlock(PDB[UIN].copy.pos.strpos, PDB[UIN].copy.pos.endpos)
                --输出提示
                msg(CL.tip.transpose.clearSuc[Lang], UIN)
            end
        end
    end

    ---------------------- 乐器刷子 ----------------------
    if(CurToolid == 11034) --钛合金耙
    then
        if(event.content == "t" or event.content == "T")
        then
            if(PDB[UIN].block_id and PDB[UIN].click_num)--看看该玩家数据库中有没有可以刷的乐器方块数据
            then --有 就打开
                PDB[UIN].Brush.state = true
                msg(string.format(CL.tip.Brush.afterChangeState[Lang],tostring(PDB[UIN].Brush.state)),UIN)
            else --没有 输出提示
                msg(CL.tip.Brush.noData[Lang], UIN)
            end
        elseif(event.content == "f" or event.content == "F")
        then
            PDB[UIN].Brush.state = false
            msg(string.format(CL.tip.Brush.afterChangeState[Lang],tostring(PDB[UIN].Brush.state)),UIN)
        else
            local num = tonumber(event.content)
            if(num >= 1 and num <= 10)
            then
                PDB[UIN].Brush.size = num
                msg(string.format(CL.tip.Brush.afterChangeSize[Lang],tostring(PDB[UIN].Brush.size)),UIN)
            end
        end
    end

    ---------------------- 乐器方块的录入数据 鼓的处理 ----------------------    
    local result,block_id=Player:getCurToolID(UIN)
    if(block_id == 693)--处理鼓的tf
    then
        if(event.content == "t" or event.content == "T")--t/f(改变生成的方式)
        then
            PDB[UIN].DrumState = true
            msg(string.format(CL.tip.drum.tipAfterChange[Lang], tostring(PDB[UIN].DrumState)), UIN)
            return 0
        elseif(event.content == "f" or event.content == "F")
        then
            PDB[UIN].DrumState = false
            msg(string.format(CL.tip.drum.tipAfterChange[Lang], tostring(PDB[UIN].DrumState)), UIN)
            return 0
        end
    end

    if((block_id == 693 and (PDB[UIN].DrumState == false)) or block_id == 694 or block_id == 695) --电子 综合 和用乐器方块方式处理的鼓
    then
        --若玩家手持道具类型是乐器方块 则赋值给对应table中的value
        PDB[UIN]['block_id']=block_id
        local num=event.content*1--获取玩家在聊天框中输入的内容 若是一个>=0且<=7的数 则进行下一步
        if(num~=nil)
        then
            if(num>=0 and num<=7)
            then
                PDB[UIN]['click_num']=num
                --提示录入的数据
                local result,name=Item:getItemName(PDB[UIN]['block_id'])
                Trigger:wait(0.1)
                msg(string.format(CL.tip.MI.entData[Lang],name,PDB[UIN]['click_num']),UIN)
                msg(CL.tip.MI.entData2[Lang], UIN)
                PDB[UIN]['z_bloid']=nil
                PDB[UIN]['z_num']=nil
                --消灭掉可能存在的音组数据
            end
        end
        return 0
    end

    ---------------------- 音调方块的生成 鼓的生成 ----------------------
    local result,blockid=Player:getCurToolID(UIN)
    if(blockid==690 or blockid==691 or blockid==692 or (blockid == 693 and PDB[UIN].DrumState))
    then
        if(event.content == " ")--如果是空格 那就做一次偏移
        then
            doOffset(UIN)
        end
        local clicknum = -1
        if(type(tonumber(event.content))=="number")--获取玩家在聊天框中输入的内容 若是一个数 则直接生成
        then
            clicknum=tonumber(event.content)
        else
            if(blockid==690 or blockid==691 or blockid==692)--若不是数 则判断字母 音调方块专用
            then
                if(event.content=="C" or event.content=="c")
                then
                    clicknum=pitchList[pitch].tone.c
                elseif(event.content=="D" or event.content=="d")
                then
                    clicknum=pitchList[pitch].tone.d
                elseif(event.content=="E" or event.content=="e")
                then
                    clicknum=pitchList[pitch].tone.e
                elseif(event.content=="F" or event.content=="f")
                then
                    clicknum=pitchList[pitch].tone.f
                elseif(event.content=="G" or event.content=="g")
                then
                    clicknum=pitchList[pitch].tone.g
                elseif(event.content=="A" or event.content=="a")
                then
                    clicknum=pitchList[pitch].tone.a
                elseif(event.content=="B" or event.content=="b")
                then
                    clicknum=pitchList[pitch].tone.b
                end
            end
        end

        if(clicknum>=0 and clicknum<=11)--若clicknum>=0且<=11 生成方块
        then
            local result,x,y,z=Actor:getPosition(UIN)--获取玩家位置
            local result=Block:setBlockAll(x,y,z,blockid,clicknum) --放置音调方块
            if(result==1001)
            then
                msg("PutMusicBlock:放置音调方块发育不正常",UIN)
                return 1001--返回发育不正常码
            end
            --位置偏移
            doOffset(UIN)
        end
        return 0
    end
end

--玩家选择快捷栏时运行
local function PlayerSelectShortcut(event)
    local UIN = event.eventobjid --我不想变量名称太长

    --如是星铜钻头 输出提示
    if(event.itemid == 11016)
    then
        msg(CL.tip.attr.Horas1[Lang], UIN)
        msg(CL.tip.attr.Horas2[Lang], UIN)
    end

    --如是平凡法杖 且开关为开 放置乐器方块...
    if(event.itemid==11580 and PDB[UIN]['switch'])
    then
        local result,x,y,z=Player:getAimPos(UIN)--获取玩家准心位置
        --若该位置的方块不是空气方块且不是光束线 则向上偏移一格
        local y1=y--保留y的初值
        local isrun=false
        local result,id=Block:getBlockID(x,y,z)
        if(id ~= 0 and id ~= 351)
        then
            y=y+1
            if(PDB[UIN]['z_bloid'] and PDB[UIN]['z_num'])--若有音组数据 再向上偏移一格(考虑到地面上的情况)
            then
                y=y+1
                isrun=true
            end
        end

        --若有音组数据 且音调处的方块不是空气 则向上偏移一格
        if(PDB[UIN]['z_bloid'] and PDB[UIN]['z_num'] and isrun==false)
        then
            local result,id=Block:getBlockID(x,y1-1,z)
            if(id~=0)
            then
                y=y1+1
            end
        end

        --康康'click_num'参数是否存在
        if(PDB[UIN]['click_num']==nil)
        then
            Trigger:wait(0.1)
            msg("乐器方块生成器:请您输入点击次数 否则程序无法发育",UIN)
            return 1001--返回发育不正常码
        end

        --放置乐器方块
        local result=Block:setBlockAll(x,y,z,PDB[UIN]['block_id'],PDB[UIN]['click_num'])
        World:playParticalEffect(x,y,z,1005,1)--播放特效
        --放置音调方块（若有） 飘窗文字提示
        local result,name=Item:getItemName(PDB[UIN]['block_id'])
        if(PDB[UIN]['z_bloid'] and PDB[UIN]['z_num'])--若有音组数据 则放置音调方块
        then
            local result=Block:setBlockAll(x,y-1,z,PDB[UIN]['z_bloid'],PDB[UIN]['z_num'])
            local result,z_name=Item:getItemName(PDB[UIN]['z_bloid'])
            notify(string.format(CL.tip.MI.pasteSuc[Lang], name, PDB[UIN]['click_num'], z_name,PDB[UIN]['z_num']), UIN)
        else--没有则只提示乐器方块的
            notify(string.format(CL.tip.MI.MIgSuc[Lang], name, PDB[UIN]['click_num']), UIN)
        end
    end

    if(event.itemid==11580) --若是平凡法杖 开启特效提示 否则关闭（变量赋值）
    then
        if(PDB[UIN]['switch']==false)
        then
            local result,name=Item:getItemName(PDB[UIN]['block_id'])
            if(name) --如果持有乐器方块数据 就提示
            then
                --飘窗文字提示
                if(PDB[UIN]['z_bloid'] and PDB[UIN]['z_num'])--若有音组数据 则提示全部的数据 
                then
                    local result,z_name=Item:getItemName(PDB[UIN]['z_bloid'])
                    notify(string.format(CL.tip.MI.ztip[Lang], name, PDB[UIN]['click_num'], z_name,PDB[UIN]['z_num']), UIN)
                else--没有则只提示乐器方块的
                    notify(string.format(CL.tip.MI.brushTip[Lang], name, PDB[UIN]['click_num']), UIN)
                end
                PDB[UIN]['switch']=true
            end
        end
    else
        PDB[UIN]['switch']=false
    end

    --如是复苏法杖 输出pat提示 不是 则关掉pat的状态
    if(event.itemid == 11584)
    then
        msg(CL.tip.pat.patTip[Lang],UIN)
        msg(CL.tip.pat.patTip2[Lang],UIN)
        --如果有就绪的数据 提示当前的数据
        if(PDB[UIN].pattern.nowPatId ~= -1)
        then
            msg(string.format(CL.tip.pat.patTip3[Lang],PDB[UIN].pattern.nowPatId),UIN)
        end
    else
        PDB[UIN].pattern.rename = false
        PDB[UIN].pattern.renameId = -1
    end

    --如是收割者 弹窗提醒 输出控制提示
    if(event.itemid==12009)
    then
        notify(CL.tip.reaper.reaperTip[Lang], UIN)
        msg(CL.tip.globalSetTip.menu[Lang], UIN)
        msg(CL.tip.globalSetTip.menu2[Lang], UIN)
        msg(CL.tip.globalSetTip.menu3[Lang], UIN)
    end

    --如是钛合金耙 输出提示
    if(event.itemid == 11034)
    then
        msg(string.format(CL.tip.Brush.tip2[Lang],tostring(PDB[UIN].Brush.state),PDB[UIN].Brush.size),UIN)
        if(PDB[UIN]['block_id'])--若有乐器数据 则提示数据 
        then
            local result,name=Item:getItemName(PDB[UIN]['block_id'])
            msg(string.format(CL.tip.MI.brushTip[Lang],name,PDB[UIN]['click_num']), UIN)
        end
    else --如果不是 关掉相关的状态
        globalSetState.chooseKey = false
        globalSetState.setOffset = false
        globalSetState.setFold = false
        globalSetState.chooseFoldPara = false
        globalSetState.setLeftPos = false
        globalSetState.setRightPos= false
        globalSetState.setFoldOffset = false
    end

    --如是雷电法杖 可取消点 或输出提示 如不是 则进行清除数据的操作
    if(event.itemid == 11582)
    then
        local pos = PDB[UIN].copy.pos --引用这个表
        --分情况
        if(pos.strpos.x and pos.endpos.x == nil)
        then
            World:stopEffectOnPosition(pos.strpos.x,pos.strpos.y,pos.strpos.z,CopyEffectId)--停止特效
            pos.strpos = {}
            msg(CL.tip.copy.canStrPos[Lang],UIN)
            return 0
        end
        if(pos.strpos.x and pos.endpos.x)
        then
            World:stopEffectOnPosition(pos.endpos.x,pos.endpos.y,pos.endpos.z,CopyEffectId)--停止特效
            pos.endpos = {}
            msg(CL.tip.copy.canEndPos[Lang],UIN)
            return 0
        end
        return 0
    else
        local pos = PDB[UIN].copy.pos --引用这个表
        if(pos.strpos.x or pos.endpos.x)
        then
            --停止特效
            World:stopEffectOnPosition(pos.strpos.x,pos.strpos.y,pos.strpos.z,CopyEffectId)
            World:stopEffectOnPosition(pos.endpos.x,pos.endpos.y,pos.endpos.z,CopyEffectId)
            --清除数据
            pos.strpos = {}
            pos.endpos = {}
            --不结束这个函数！这只是附带的功能！
        end
    end

    --如果是鼓方块 输出提示
    if(event.itemid == 693)
    then
        msg(CL.tip.drum.drumtip[Lang], UIN)
        msg(string.format(CL.tip.drum.displaystate[Lang],tostring(PDB[UIN].DrumState)), UIN)
        return 0
    end

    --如是极寒域法杖 输出提示
    if(event.itemid == 11668)
    then
        if(PDB[UIN].copy.direction.x )--有数据
        then
            msg(string.format(CL.tip.copy.patTip[Lang],PDB[UIN].copy.way),UIN)
            msg(CL.tip.copy.patTip2[Lang],UIN)
            msg(CL.tip.copy.patTip3[Lang], UIN)
        else
            msg(CL.tip.copy.patTip3[Lang], UIN)
        end
        return 0
    end

    --如果是巨人核心或推拉机械臂 输出提示
    if(event.itemid == 1059 or event.itemid == 368)
    then
        local result, name = Item:getItemName(event.itemid) --获取道具的名称
        local str = string.format(CL.tip.armAndGiant.tip[Lang], name) --制作一个消息
        msg(str, UIN) --对玩家输出
    end
    return 0
end

--每秒运行一次
local function Game_RunTime(event)
    if(event.second)
    then
        for playerid,tab in pairs(PDB)
        do
            if(tab['switch'])
            then
                local result,x,y,z=Player:getAimPos(playerid)--获取玩家准星位置
                World:playParticalEffect(x,y,z,1182,1)--播放特效
            end
        end
    end
end

--玩家点击方块时运行
local function ClickBlock(event)
    local UIN = event.eventobjid --我不想变量名称太长

    --收割者清除方块
    local result,itemid=Player:getCurToolID(UIN)
    if(itemid==12009)--若是收割者
    then--破坏掉那个方块 结束函数
        Block:destroyBlock(event.x,event.y,event.z,false)
        return 0
    end
    --提示方块类型 数据
    local result,name=Item:getItemName(event.blockid)
    local result,data=Block:getBlockData(event.x,event.y,event.z)
    msg(string.format(CL.tip.blockTip.tip1[Lang], name, event.blockid), UIN)
    msg(string.format(CL.tip.blockTip.tip2[Lang], event.x, event.y, event.z, data), UIN)
    return 0
end

--方块被撸时运行
local function BlockDigBegin(event)
    local UIN = event.eventobjid --我不想变量名称太长
    local result,item_id=Player:getCurToolID(UIN)--获得手持道具id

    --乐器方块部分的音组复制数据录入
    if(item_id==11580)
    then
        if(event.blockid==693 or event.blockid==694 or event.blockid==695)
        then
            local result,data=Block:getBlockData(event.x,event.y,event.z)
            PDB[UIN]['block_id']=event.blockid
            PDB[UIN]['click_num']=data
            local result,id=Block:getBlockID(event.x,event.y-1,event.z)--下面的音调方块id
            if(id==690 or id==691 or id==692)
            then
                local result,data=Block:getBlockData(event.x,event.y-1,event.z)
                PDB[UIN]['z_bloid']=id
                PDB[UIN]['z_num']=data
                local result,name=Item:getItemName(PDB[UIN].block_id)
                local result,z_name=Item:getItemName(PDB[UIN].z_bloid)
                msg(string.format(CL.tip.MI.entData[Lang], name, PDB[UIN]['click_num']), UIN)
                msg(string.format(CL.tip.MI.entData4[Lang], z_name, PDB[UIN]['z_num']),UIN)
                msg(CL.tip.MI.entData2[Lang], UIN)
                return 0
            end
            local result,name=Item:getItemName(PDB[UIN]['block_id'])
            msg(string.format(CL.tip.MI.entData[Lang],name,PDB[UIN]['click_num']),UIN)
            msg(CL.tip.MI.entData2[Lang], UIN)
            msg(CL.tip.MI.entData3[Lang], UIN)
        end
        return 0
    end

    --框选区域之锚定坐标点
    if(item_id == 11582)
    then
        --起点
        if(PDB[UIN].copy.pos.strpos.x == nil and PDB[UIN].copy.pos.endpos.x == nil)
        then
            PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z = event.x,event.y,event.z
            World:playParticalEffect(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z,CopyEffectId,1) --在锚定的点上播放特效
            msg(string.format(CL.tip.copy.strPos[Lang], PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z),UIN)
            msg(CL.tip.copy.tip2[Lang], UIN)
            return 0
        end

        --终点
        if(PDB[UIN].copy.pos.strpos.x and PDB[UIN].copy.pos.endpos.x == nil)
        then
            PDB[UIN].copy.pos.endpos.x, PDB[UIN].copy.pos.endpos.y, PDB[UIN].copy.pos.endpos.z = event.x,event.y,event.z
            World:playParticalEffect(PDB[UIN].copy.pos.endpos.x, PDB[UIN].copy.pos.endpos.y, PDB[UIN].copy.pos.endpos.z ,CopyEffectId,1) --在锚定的点上播放特效
            msg(string.format(CL.tip.copy.endPos[Lang],PDB[UIN].copy.pos.endpos.x, PDB[UIN].copy.pos.endpos.y, PDB[UIN].copy.pos.endpos.z ),UIN)
            msg(CL.tip.copy.tip2[Lang], UIN)
            msg(CL.tip.copy.tip3[Lang], UIN)
            msg(CL.tip.copy.tip4[Lang], UIN)
            return 0
        end
    end
end

--玩家使用道具时执行
local function useitem(event)
    local UIN = event.eventobjid --我不想变量名称太长

    --平凡法杖 瞬移
    if(event.itemid == 11580)
    then
        local result,x,y,z=Player:getAimPos(UIN)--获取玩家准心位置
        Actor:setPosition(UIN,x,y,z) --瞬移
        return 0
    end

    --星铜钻头 飘移
    if(event.itemid == 11016)
    then
        --从玩家数据库中抽取该玩家的力度
        local force = PDB[UIN].attr.force
        local result, dirx, diry, dirz = Actor:getFaceDirection(UIN)--获取该玩家的面朝方向
        --计算弹飞玩家的参数 弹飞玩家
        local x, y, z = dirx * force, diry * force, dirz * force
        Actor:appendSpeed(UIN, x, y, z)
    end

    --雷电法杖 框选区域之锚定坐标点和录入复制数据
    if(event.itemid == 11582)
    then
        --起点
        if(PDB[UIN].copy.pos.strpos.x == nil and PDB[UIN].copy.pos.endpos.x == nil)
        then
            local result,x,y,z=Actor:getPosition(UIN)
            PDB[UIN].copy.pos.strpos.x = x
            PDB[UIN].copy.pos.strpos.y = y
            PDB[UIN].copy.pos.strpos.z = z
            World:playParticalEffect(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z,CopyEffectId,1) --在锚定的点上播放特效
            msg(string.format(CL.tip.copy.strPos[Lang],PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z),UIN)
            msg(CL.tip.copy.tip2[Lang], UIN)
            return 0
        end

        --终点
        if(PDB[UIN].copy.pos.strpos.x and PDB[UIN].copy.pos.endpos.x == nil)
        then
            local result,x,y,z=Actor:getPosition(UIN)
            PDB[UIN].copy.pos.endpos.x = x
            PDB[UIN].copy.pos.endpos.y = y
            PDB[UIN].copy.pos.endpos.z = z
            World:playParticalEffect(PDB[UIN].copy.pos.endpos.x, PDB[UIN].copy.pos.endpos.y, PDB[UIN].copy.pos.endpos.z ,CopyEffectId,1) --在锚定的点上播放特效
            msg(string.format(CL.tip.copy.endPos[Lang],PDB[UIN].copy.pos.endpos.x, PDB[UIN].copy.pos.endpos.y, PDB[UIN].copy.pos.endpos.z),UIN)
            msg(CL.tip.copy.tip2[Lang], UIN)
            msg(CL.tip.copy.tip3[Lang], UIN)
            msg(CL.tip.copy.tip4[Lang], UIN)

            --之后 提醒玩家可以进行选区移调和乐器方块替换的功能
            Trigger:wait(3) --等待3秒
            --输出一些提示
            msg(CL.tip.transpose.tip1[Lang], UIN)
            Trigger:wait(1) --等待1秒
            msg(CL.tip.transpose.ordTip1[Lang], UIN)
            msg(CL.tip.transpose.ordTip2[Lang], UIN)
            Trigger:wait(1) --等待1秒
            msg(CL.tip.transpose.ordTip3[Lang], UIN)
            msg(CL.tip.transpose.ordTip4[Lang], UIN)
            Trigger:wait(1) --等待1秒
            msg(CL.tip.transpose.ordTip5[Lang], UIN)
            msg(CL.tip.transpose.ordTip6[Lang], UIN)
            return 0
        end

        --录入数据（相当于复制到剪贴板）
        if(PDB[UIN].copy.pos.strpos.x and PDB[UIN].copy.pos.endpos.x)
        then
            --末位置减去初位置，得到相对于原点的向量
            PDB[UIN].copy.vector.x = PDB[UIN].copy.pos.endpos.x - PDB[UIN].copy.pos.strpos.x
            PDB[UIN].copy.vector.y = PDB[UIN].copy.pos.endpos.y - PDB[UIN].copy.pos.strpos.y
            PDB[UIN].copy.vector.z = PDB[UIN].copy.pos.endpos.z - PDB[UIN].copy.pos.strpos.z
            local direction = PDB[UIN].copy.direction
            PDB[UIN].copy.direction = {x=1,y=1,z=1} --the direction of the vector 向量的方向
            --考虑负的情况
            if(PDB[UIN].copy.vector.x < 0)
            then
                PDB[UIN].copy.direction.x = -1
            end
            if(PDB[UIN].copy.vector.y < 0)
            then
                PDB[UIN].copy.direction.y = -1
            end
            if(PDB[UIN].copy.vector.z < 0)
            then
                PDB[UIN].copy.direction.z = -1
            end
            --输出提示
            msg(string.format(CL.tip.copy.strEntData[Lang], PDB[UIN].copy.vector.x, PDB[UIN].copy.vector.y, PDB[UIN].copy.vector.z, PDB[UIN].copy.direction.x, PDB[UIN].copy.direction.y, PDB[UIN].copy.direction.z),UIN)

            --执行复制函数
            ctrl_c(UIN)

            --停止起点和终点的特效
            World:stopEffectOnPosition(PDB[UIN].copy.pos.strpos.x, PDB[UIN].copy.pos.strpos.y, PDB[UIN].copy.pos.strpos.z,CopyEffectId)
            World:stopEffectOnPosition(PDB[UIN].copy.pos.endpos.x, PDB[UIN].copy.pos.endpos.y, PDB[UIN].copy.pos.endpos.z,CopyEffectId)

            --将起点和终点的数据保存至keep 以备存入pat
            PDB[UIN].copy.keepPos.strpos.x = PDB[UIN].copy.pos.strpos.x
            PDB[UIN].copy.keepPos.strpos.y = PDB[UIN].copy.pos.strpos.y
            PDB[UIN].copy.keepPos.strpos.z = PDB[UIN].copy.pos.strpos.z
            PDB[UIN].copy.keepPos.endpos.x = PDB[UIN].copy.pos.endpos.x
            PDB[UIN].copy.keepPos.endpos.y = PDB[UIN].copy.pos.endpos.y
            PDB[UIN].copy.keepPos.endpos.z = PDB[UIN].copy.pos.endpos.z

            --清除起点和终点的数据
            PDB[UIN].copy.pos.strpos = {}
            PDB[UIN].copy.pos.endpos = {}
            return 0
        end
    end

    --极寒域法杖 粘贴 
    if(event.itemid == 11668)
    then
        if(PDB[UIN].copy.direction.x)
        then
            msg(CL.tip.copy.startPaste[Lang],UIN)
            ctrl_v(UIN)
        end
        return 0
    end

    --复苏法杖 粘贴
    if(event.itemid == 11584)
    then
        pastePat(UIN)
        return 0
    end
end

--玩家移动时执行
local function MoveOneBlockSize(event)
    local UIN = event.eventobjid
    --看看玩家刷子有没有打开
    if(PDB[UIN].Brush.state)
    then --若有 则执行刷子
        Brush(UIN)
    end
end

---------------------- 事件监听器 ----------------------
--注册玩家输入字符串监听器  
ScriptSupportEvent:registerEvent([=[Player.NewInputContent]=],PlayerNewInputContent)
--注册玩家进入游戏监听器
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.EnterGame]=],Game_AnyPlayer_EnterGame)
--注册玩家离开游戏监听器
ScriptSupportEvent:registerEvent([=[Game.AnyPlayer.LeaveGame]=],Game_AnyPlayer_LeaveGame)
--注册玩家选择快捷栏监听器
ScriptSupportEvent:registerEvent([=[Player.SelectShortcut]=],PlayerSelectShortcut)
--每秒运行一次的事件
ScriptSupportEvent:registerEvent([=[Game.RunTime]=],Game_RunTime)
--注册玩家点击方块监听器
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],ClickBlock)--{eventobjid, blockid, x, y, z}
--注册方块被撸监听器
ScriptSupportEvent:registerEvent([=[Block.Dig.Begin]=],BlockDigBegin)--   {eventobjid, blockid, x, y, z}
--注册玩家使用道具监听器
ScriptSupportEvent:registerEvent([=[Player.UseItem]=],useitem)--eventobjid,itemid,itemnum,itemix
--注册玩家移动监听器
ScriptSupportEvent:registerEvent([=[Player.MoveOneBlockSize]=], MoveOneBlockSize) --eventobjid,shortix,x,y,z

-----------------------------------------------------------------------------------------------------------------------------------------

--[[{
更新日志awa
    v1.0 2023.01.20
    基本框架 使用方法：手持道具（鼓 电子 综合 乐器方块）输入音块的点击次数 站在目标位置上按下潜行键 自动生成对应的音乐方块
    
    后多次更新 修复bug等 作者未详记
    
    v1.5 2023.03.04
    修改使用方法 用平凡法杖做生成工具 
    修改数据存储方法 联机房间中房主和各玩家均可以正常使用
    
    v1.6 2023.03.05
    增加更多提示功能 优化特效
    
    v1.7 2023.03.05
    将音调方块的生成和乐器方块的生成合并为一个项目 音乐方块生成器 便于玩家使用
    
    v1.8 2023.03.06 
    在玩家背包中检测和添加初始道具
    
    v1.9 2023.03.25
    新增音乐组（音调+乐器）复制功能
    新增玩家飞行功能（玩家在聊天框中输入“飞”或“落”进行控制）
    新增音调方块生成后玩家脱身功能 避免被方块卡住
    新增点击方块后显示方块坐标等信息功能
    新增玩家手持道具收割者(12009)点击方块将其清除的功能
    优化提示
    
    v1.10 2023.7.24
    新增使用说明 修改了intro
    将玩家的初始状态改为飞行
    修改生成规则以适应新电路
    
    v1.10.1 2023.7.29
    新增使用平凡法杖瞬移功能
    修改提示
    修复了提示的bug
    
    v1.11 2023.8.4
    新增区域内音乐方块复制功能
    
    v1.12 2023.9.3
    乐器刷子
        玩家手持乐器方块输入点击次数录入数据
        玩家刷子状态为true时 行走时 以玩家为中心点 在周围未放乐器的音调方块上 刷上对应的乐器
        手持刷子钛合金耙 输入数字 大于1小于10 可改变刷子大小 默认为2
    pattern功能 
        pat数据库 保存所有玩家的pat
        玩家可将当前复制的区域方块数据保存为pattern
        玩家手持复苏法杖输入指令控制pat
        使用复苏法杖粘贴pat
    鼓的生成 加入生成状态 手持鼓 输入t/f控制状态 bool值为真 则像音调方块一样在玩家位置处生成 默认为假 即像乐器一样用平凡法杖放
    修复bug
        音调方块生成时 数据乱跑（输入东西不标准也生成）
    优化提示
    优化数据结构（重构部分代码）
    新增语言选项 英语 English 
    把聊天框弹提示和飘窗文字函数重载 规范化参数避免缺参
    将石矛改为平凡法杖 避免玩家使用时丢出
    收割者 添加设置命令 可改变调性、位置偏移、语言

    v1.12.1 2023.11.7
    修复bug
        设置位置偏移时 输入负数无法接受的问题
        修复intro的问题

    v1.13
    bug修复
        修复玩家在没有复制音乐区域的情况下 手持复苏法杖进行pat录入提示错误的问题 --
    通用功能更新
        修改部分提示 -
        加速道具&人物大小设置 星铜钻头11016（前是铜 不是瞳） abc三个选项 --
            a 输入数字可设置自己移动速度 使用可向前冲刺
            b 输入数字可设置自己模型大小 可改变自己的大小以钻入一格高的地方
            c 输入数字 调整弹飞的力度
        检测手持道具信息功能 可显示id 名字 输入"id"(不分大小写)查看 --
    音乐部分
        玩家输入空格 向预设方向偏移一次 --
        新增选区移调与乐器方块替换功能 仅适用于音乐(整合到雷电法杖与极寒域法杖部分) --
        放置音调方块后的玩家位置偏移可选 确定偏移方向 适配s形折轨的音乐地图 --
    新增电路元件类辅助
        过山车轨道一键放置功能 带指示灯 (玩家需要手动制作一个周期的轨道 然后录入自动生成)
        巨人核心生成功能 手持 输入数字控制朝向 在玩家处生成 --
        推拉机械臂花纹星能块一键放置功能（输入数字控制朝向） --
        封轨 拆轨(把音轨的星能分流器发出的光束线用指定方块截断 与其逆过程(手持道具输入控制))
    新增音乐地图装饰辅助选区类（烈焰/冰魄法杖）
        新增选区无限堆叠功能（用于装饰）
        新增装饰pattern功能（同音乐pat那样）
        新增选区根据方块id和data选择性删除/替换/清空功能 (整合到烈焰/冰魄法杖部分)
    新增其他装饰辅助类
        山生成器：可设定山高度 顶层/中层/底层方块id data和层数 生成范围大小
        随机在玩家周围生成指定id data的方块 可调区域形状大小 方块密度 生成数 是否无视原有方块生成 模式（向心/离散）
    
    后面打一个-表示该功能已经在开发中 2个- 表示已完成

--}]]
