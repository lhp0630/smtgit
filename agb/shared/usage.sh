# Bilingual help / usage strings (RFC-DOC-002 §7.14, research L1).
# Command names and flags stay English in both corpora.

usage_root_en() {
  cat <<EOF
Usage: agb.sh [--lang en|zh] <command> [options]

agb (agent governance bootstrap) — architecture skeleton ${AGB_VERSION}

Commands (RFC-DOC-002 §7.6):
  init              Install selected pack modules (stub)
  scan              Inventory agent/docs/RFC signals (stub)
  plan migrate      Build immutable migration plan (stub)
  plan approve      Record human plan approval (stub; Phase 2+)
  apply             Apply an approved plan (stub; Phase 2+)
  validate          Validate pack / triad / lock / isolation (stub)
  update            Three-way pack update (stub; Phase 4+)
  doctor            Health / drift diagnostics (stub; Phase 4+)
  rollback          Restore from backup / transaction (stub; Phase 2+)
  research          Emit Research Task Prompt (stub)
  rfc               Emit RFC Authoring Prompt (stub; requires review evidence)
  pack fetch        Fetch/verify pinned pack to cache (stub)
  pack emit         Emit Prompt-only kit (stub; --prompt-only in full design)
  help              Show help for agb or a specific command

Global options:
  --lang en|zh      Override UI language for help (also: AGB_LANG)
                    Default follows LC_ALL / LC_MESSAGES / LANG (see RFC §7.14).

This tree is product staging. Stubs exit 2 until implemented.
See: docs/architecture/skeleton.md and RFC-DOC-002.

Examples:
  bash agb.sh help
  bash agb.sh --lang zh help
  bash agb.sh help init
  bash agb.sh validate
EOF
}

usage_root_zh() {
  cat <<EOF
用法: agb.sh [--lang en|zh] <command> [options]

agb（agent governance bootstrap）— 架构骨架 ${AGB_VERSION}

命令（RFC-DOC-002 §7.6）：
  init              安装所选 Pack 模块（桩）
  scan              盘点 agent/docs/RFC 信号（桩）
  plan migrate      生成不可变迁移计划（桩）
  plan approve      记录人类对计划的批准（桩；Phase 2+）
  apply             执行已批准计划（桩；Phase 2+）
  validate          校验 Pack / 三角 / lock / 示例隔离（桩）
  update            三路 Pack 升级（桩；Phase 4+）
  doctor            健康 / 漂移诊断（桩；Phase 4+）
  rollback          从备份 / 事务回滚（桩；Phase 2+）
  research          发出 Research Task Prompt（桩）
  rfc               发出 RFC Authoring Prompt（桩；需调研评审证据）
  pack fetch        获取并校验钉死的 Pack 到缓存（桩）
  pack emit         发出 Prompt-only kit（桩；完整设计含 --prompt-only）
  help              显示 agb 或指定命令的帮助

全局选项：
  --lang en|zh      覆盖 help 界面语言（亦可设 AGB_LANG）
                    默认跟随 LC_ALL / LC_MESSAGES / LANG（见 RFC §7.14）。

本目录为产品暂存。业务命令在实现前以退出码 2 作为桩。
参见：docs/architecture/skeleton.md 与 RFC-DOC-002。

示例：
  bash agb.sh help
  bash agb.sh --lang en help
  bash agb.sh help init
  bash agb.sh validate
EOF
}

usage_init_en() {
  cat <<'EOF'
Usage: agb.sh init [options]

Install selected Governance Pack modules into a target repository.
Creates Project Overlay and .agb/lock.yaml (design).

Status: architecture stub — not implemented.
MVP: yes (RFC-DOC-002 §7.6). Examples module default: off.
EOF
}

usage_init_zh() {
  cat <<'EOF'
用法: agb.sh init [options]

向目标仓库安装所选 Governance Pack 模块。
创建 Project Overlay 与 .agb/lock.yaml（设计）。

状态：架构桩 — 尚未实现。
MVP：是（RFC-DOC-002 §7.6）。Examples 模块默认关闭。
EOF
}

usage_scan_en() {
  cat <<'EOF'
Usage: agb.sh scan [options]

Inventory agent/docs/RFC/ADR/CI/stack signals → inventory artifact.
Default: report only (does not mutate governance trees).

Status: architecture stub — not implemented.
EOF
}

usage_scan_zh() {
  cat <<'EOF'
用法: agb.sh scan [options]

盘点 agent/docs/RFC/ADR/CI/技术栈信号 → inventory 工件。
默认：仅报告（不修改治理目录树）。

状态：架构桩 — 尚未实现。
EOF
}

usage_plan_en() {
  cat <<'EOF'
Usage: agb.sh plan <subcommand>

Subcommands:
  migrate    Build an immutable migration plan from inventory + pack
  approve    Bind human approval to a plan hash (Phase 2+)

plan migrate never mutates governance content trees.
apply only consumes an approved plan whose checksum still matches.

Status: architecture stub — not implemented.
EOF
}

usage_plan_zh() {
  cat <<'EOF'
用法: agb.sh plan <subcommand>

子命令：
  migrate    根据 inventory + pack 生成不可变迁移计划
  approve    将人类批准绑定到计划哈希（Phase 2+）

plan migrate 永不修改治理内容树。
apply 只消费校验和仍匹配的已批准计划。

状态：架构桩 — 尚未实现。
EOF
}

usage_apply_en() {
  cat <<'EOF'
Usage: agb.sh apply [options]

Execute an approved migration plan transactionally
(backup → apply → validate; audit log under .agb/).

Status: architecture stub — Phase 2+ (MVP may document dry-run only).
EOF
}

usage_apply_zh() {
  cat <<'EOF'
用法: agb.sh apply [options]

事务性地执行已批准的迁移计划
（备份 → 应用 → 校验；审计日志位于 .agb/）。

状态：架构桩 — Phase 2+（MVP 可仅文档化 dry-run）。
EOF
}

usage_validate_en() {
  cat <<'EOF'
Usage: agb.sh validate [options]

Check pack completeness, triad paths, lock, anti-loss, and
Examples isolation (RFCs/examples/ vs active sequence).

Status: architecture stub — not implemented.
EOF
}

usage_validate_zh() {
  cat <<'EOF'
用法: agb.sh validate [options]

检查 Pack 完整性、决策三角路径、lock、防丢失，
以及 Examples 隔离（RFCs/examples/ 相对活跃序列）。

状态：架构桩 — 尚未实现。
EOF
}

usage_update_en() {
  cat <<'EOF'
Usage: agb.sh update [options]

Detect upstream pack delta; three-way merge managed files.

Status: architecture stub — Phase 4+.
EOF
}

usage_update_zh() {
  cat <<'EOF'
用法: agb.sh update [options]

检测上游 Pack 差异；对受管文件做三路合并。

状态：架构桩 — Phase 4+。
EOF
}

usage_doctor_en() {
  cat <<'EOF'
Usage: agb.sh doctor [options]

Health/drift diagnostics vs lock + manifest.

Status: architecture stub — Phase 4+.
EOF
}

usage_doctor_zh() {
  cat <<'EOF'
用法: agb.sh doctor [options]

相对 lock + manifest 的健康 / 漂移诊断。

状态：架构桩 — Phase 4+。
EOF
}

usage_rollback_en() {
  cat <<'EOF'
Usage: agb.sh rollback --backup <txn_id>

Restore from a named backup / transaction; retain audit log.

Status: architecture stub — Phase 2+.
EOF
}

usage_rollback_zh() {
  cat <<'EOF'
用法: agb.sh rollback --backup <txn_id>

从指定备份 / 事务恢复；保留审计日志。

状态：架构桩 — Phase 2+。
EOF
}

usage_research_en() {
  cat <<'EOF'
Usage: agb.sh research [--idea <path>] [--out <path>]

Emit a Research Task Prompt (emit-first; does not author the report).

Status: architecture stub — not implemented.
Seed draft: prompts/research-task.md
EOF
}

usage_research_zh() {
  cat <<'EOF'
用法: agb.sh research [--idea <path>] [--out <path>]

发出 Research Task Prompt（emit-first；不撰写调研报告正文）。

状态：架构桩 — 尚未实现。
种子草案：prompts/research-task.md
EOF
}

usage_rfc_en() {
  cat <<'EOF'
Usage: agb.sh rfc --research-report <path> --research-review <path> [--out <path>]

Emit an RFC Authoring Prompt only when research review evidence is valid
(named human + report sha256 + decision=approve_for_rfc).

Status: architecture stub — not implemented.
Seed draft: prompts/rfc-from-research.md
EOF
}

usage_rfc_zh() {
  cat <<'EOF'
用法: agb.sh rfc --research-report <path> --research-review <path> [--out <path>]

仅在调研评审证据有效时发出 RFC Authoring Prompt
（具名人类 + 报告 sha256 + decision=approve_for_rfc）。

状态：架构桩 — 尚未实现。
种子草案：prompts/rfc-from-research.md
EOF
}

usage_pack_en() {
  cat <<'EOF'
Usage: agb.sh pack <subcommand>

Subcommands:
  fetch    Download/verify pin to local cache
  emit     Emit kit directory (design: --prompt-only)

Status: architecture stub — not implemented.
Kit skeleton: kits/prompt-only/
EOF
}

usage_pack_zh() {
  cat <<'EOF'
用法: agb.sh pack <subcommand>

子命令：
  fetch    下载 / 校验钉死版本到本地缓存
  emit     发出 kit 目录（设计：--prompt-only）

状态：架构桩 — 尚未实现。
Kit 骨架：kits/prompt-only/
EOF
}

# Dispatchers — select corpus by agb_ui_lang.
usage_root() {
  case "$(agb_ui_lang)" in
    zh) usage_root_zh ;;
    *) usage_root_en ;;
  esac
}

usage_init() {
  case "$(agb_ui_lang)" in
    zh) usage_init_zh ;;
    *) usage_init_en ;;
  esac
}

usage_scan() {
  case "$(agb_ui_lang)" in
    zh) usage_scan_zh ;;
    *) usage_scan_en ;;
  esac
}

usage_plan() {
  case "$(agb_ui_lang)" in
    zh) usage_plan_zh ;;
    *) usage_plan_en ;;
  esac
}

usage_apply() {
  case "$(agb_ui_lang)" in
    zh) usage_apply_zh ;;
    *) usage_apply_en ;;
  esac
}

usage_validate() {
  case "$(agb_ui_lang)" in
    zh) usage_validate_zh ;;
    *) usage_validate_en ;;
  esac
}

usage_update() {
  case "$(agb_ui_lang)" in
    zh) usage_update_zh ;;
    *) usage_update_en ;;
  esac
}

usage_doctor() {
  case "$(agb_ui_lang)" in
    zh) usage_doctor_zh ;;
    *) usage_doctor_en ;;
  esac
}

usage_rollback() {
  case "$(agb_ui_lang)" in
    zh) usage_rollback_zh ;;
    *) usage_rollback_en ;;
  esac
}

usage_research() {
  case "$(agb_ui_lang)" in
    zh) usage_research_zh ;;
    *) usage_research_en ;;
  esac
}

usage_rfc() {
  case "$(agb_ui_lang)" in
    zh) usage_rfc_zh ;;
    *) usage_rfc_en ;;
  esac
}

usage_pack() {
  case "$(agb_ui_lang)" in
    zh) usage_pack_zh ;;
    *) usage_pack_en ;;
  esac
}
