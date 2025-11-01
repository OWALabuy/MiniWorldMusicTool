# 『异端世方』音乐方块生成器 v2.0 - 框架设计

## 概述

这是基于**有限状态机**和**模块化架构**重构的音乐方块生成器框架，适配迷你世界开发3.0模式。

## 目录结构

```
框架设计/
├── MusicTool.lua                 # 主脚本组件（挂载到世界对象）
├── Core/                         # 核心系统
│   ├── StateMachine.lua         # 状态机引擎
│   ├── PlayerSession.lua        # 玩家会话管理
│   └── CommandRouter.lua        # 命令路由
├── Modules/                      # 功能模块（状态机实现）
│   ├── ToneBlockGenerator.lua   # 音调方块生成
│   ├── InstrumentBlock.lua      # 乐器方块生成
│   ├── Brush.lua                # 乐器刷子
│   ├── AreaCopyPaste.lua        # 区域复制粘贴
│   ├── Pattern.lua              # Pattern管理
│   ├── AreaPattern.lua          # AreaPAT管理
│   ├── FoldConfig.lua           # 折轨配置（示例）
│   ├── GlobalSettings.lua       # 全局设置
│   ├── Measure.lua              # 小节标记
│   ├── TrackSeal.lua            # 封轨/拆轨
│   └── RailPlace.lua            # 过山车轨道
├── Commands/                     # 命令处理器
│   ├── Global/                  # 全局命令
│   │   ├── ShowId.lua           # 显示道具ID（示例）
│   │   └── ClearInstrumentData.lua
│   └── ToneBlock/               # 音调方块命令
│   └── InstrumentBlock/         # 乐器方块命令
│   └── ...                      # 其他工具命令
├── Utils/                        # 工具模块
│   ├── I18N.lua                 # 国际化
│   ├── Constants.lua            # 常量定义
│   ├── BlockUtils.lua           # 方块操作工具
│   └── Geometry.lua             # 几何计算工具
└── Data/                         # 数据管理
    └── Storage.lua              # Pattern/AreaPAT存储
```

## 核心概念

### 1. 分层状态机

- **全局层**：系统初始化、生命周期管理
- **玩家会话层**：每个玩家的独立状态机（IDLE → WAITING_INPUT → FLOW_ACTIVE等）
- **功能模块层**：各个具体功能的子状态机（如折轨配置流程）
- **命令路由层**：命令解析与分发

### 2. 玩家会话（PlayerSession）

每个玩家有一个独立的会话对象，包含：
- **状态**：当前玩家状态（空闲、等待输入、流程进行中等）
- **数据**：玩家的所有数据（兼容原有PDB结构）
- **当前工具**：手持的道具ID
- **当前流程**：正在进行的多步交互流程

### 3. 流程（Flow）

多步交互的统一管理机制，例如：
- 折轨配置：选择方向 → 设置左轨 → 设置右轨 → 设置偏移
- Pattern重命名：输入ID → 输入新名称
- 小节标记设置：锚定第一点 → 锚定第二点 → 输入小节数

每个流程包含：
- **类型**：流程类型标识
- **步骤**：当前步骤号
- **数据**：流程上下文数据
- **超时时间**：自动清理机制

### 4. 命令路由（CommandRouter）

命令处理优先级：
1. **活跃流程输入**：如果有流程，输入优先路由到流程
2. **工具命令**：根据当前手持道具匹配命令
3. **全局命令**：不依赖道具的通用命令

## 使用指南

### 添加新功能模块

1. 在 `Modules/` 下创建新模块文件
2. 实现流程接口：
   ```lua
   local MyModule = {}
   
   function MyModule:OnEnter(session, flow)
       -- 流程开始时调用
   end
   
   function MyModule:OnInput(session, flow, input)
       -- 处理用户输入，返回 "continue" / "complete" / "cancel"
   end
   
   function MyModule:OnComplete(session, flow)
       -- 流程完成时调用
   end
   
   function MyModule:OnCancel(session, flow)
       -- 流程取消时调用
   end
   
   return MyModule
   ```

3. 在 `StateMachine.lua` 中注册：
   ```lua
   self:RegisterFlow(FlowType.MY_FLOW, require("Modules.MyModule"))
   ```

### 添加新命令

1. **全局命令**：在 `Commands/Global/` 下创建文件
   ```lua
   local MyCommand = {}
   
   function MyCommand:Process(session, input)
       -- 处理命令逻辑
       return "handled"  -- 或 "not_handled"
   end
   
   return MyCommand
   ```

2. **工具命令**：在对应工具目录下创建文件
   ```lua
   local ToolCommand = {}
   
   function ToolCommand:Process(session, input)
       -- 处理命令逻辑
       return "handled"
   end
   
   return ToolCommand
   ```

3. 在 `CommandRouter.lua` 中注册：
   ```lua
   -- 全局命令
   self:RegisterGlobalCommand("mycmd", require("Commands.Global.MyCommand"))
   
   -- 工具命令
   self:RegisterToolCommand(ITEM_ID, "category", require("Commands.Tool.ToolCommand"))
   ```

### 添加新文案

在 `Utils/I18N.lua` 的 `messages` 表中添加：
```lua
local messages = {
    tip = {
        myFeature = {
            success = {
                "#c8bf6ab操作成功",
                "#c8bf6abOperation successful"
            },
        },
    },
}
```

使用：
```lua
local I18N = require("Utils.I18N")
I18N:SendMessage(UIN, "tip.myFeature.success")
I18N:SendMessage(UIN, "tip.myFeature.success", param1, param2)  -- 带参数
```

### 访问玩家数据

```lua
local PlayerSession = require("Core.PlayerSession")
local session = PlayerSession:GetSession(UIN)

-- 访问数据
local toneBlock = session.data.toneBlock
local instrumentSwitch = session.data.instrumentSwitch

-- 修改数据
session.data.brush.enabled = true
session.data.copy.way = 2
```

### 启动流程

```lua
local StateMachine = require("Core.StateMachine")
StateMachine:StartFlow(session, FlowType.FOLD_CONFIG, {
    initialParam = value,
})
```

## 开发规范

1. **模块化**：每个功能独立成模块，减少耦合
2. **状态管理**：统一通过 StateMachine 管理状态转换
3. **数据访问**：统一通过 PlayerSession 访问玩家数据
4. **错误处理**：流程中妥善处理异常情况，及时清理状态
5. **超时保护**：所有流程都要设置合理的超时时间
6. **多语言**：所有用户可见文本都要支持多语言

## 迁移计划

1. **第一阶段**：实现核心框架（StateMachine、PlayerSession、CommandRouter）
2. **第二阶段**：迁移简单命令（ShowId、ClearInstrumentData等）
3. **第三阶段**：迁移简单模块（音调方块生成、乐器方块生成）
4. **第四阶段**：迁移复杂流程（折轨配置、Pattern管理）
5. **第五阶段**：迁移剩余功能（区域复制粘贴、刷子等）
6. **第六阶段**：测试、优化、文档完善

## 注意事项

1. 迷你世界3.0的API可能与2.0有差异，需要对照官方文档调整
2. 事件参数结构可能不同，需要适配
3. 某些API可能不可用，需要找替代方案
4. 保持与原功能的完全兼容，确保用户体验一致

