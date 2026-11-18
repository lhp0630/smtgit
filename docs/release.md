# release

通过 Git tag 触发 GitHub Actions，打包仓库并发布到 GitHub Release。

面向仓库维护者。总览入口见根目录 [README.md](../README.md)。

## 背景：Tag ≠ Release

| 操作 | 结果 |
|------|------|
| 仅创建并推送 Git tag | 仓库上出现 tag；**不会**默认创建 GitHub Release |
| 在 GitHub 上「Draft a new release」 | 可选用已有 tag，或同时新建 tag，并创建 Release |
| 推送匹配 `v*` 的 tag（本仓库） | [`.github/workflows/release.yml`](../.github/workflows/release.yml) 创建 Release，并上传打包产物 |

GitHub 在已有 Release 时会额外提供该 tag 对应的源码 zip/tarball 下载链接；本 workflow 另附带精简后的项目归档（不含 `.git` / CI 目录）。

## 前提

- 对目标远程仓库有推送 tag 的权限
- 仓库已启用 GitHub Actions
- workflow 声明了 `contents: write`（已在 YAML 中配置），以便创建 Release 并上传资产

## 命令

```bash
git tag v<major>.<minor>.<patch>
git push origin v<major>.<minor>.<patch>
```

| 项 | 说明 |
|----|------|
| Tag 格式 | 必须以 `v` 开头（例如 `v1.0.0`），否则 workflow 不触发 |
| 触发条件 | `push` 事件且 tag 名匹配 `v*` |

## 工作流程

```text
1. 维护者推送 tag（如 v1.0.0）
2. Actions 检出该 tag 对应提交
3. 将 smtgit.sh、shared/、docs/、README.md、AGENTS.md 打入
   smtgit-<version>/ 目录
4. 生成 dist/smtgit-<version>.tar.gz 与 .zip
5. softprops/action-gh-release 创建同名 Release
   - 标题：smtgit <version>
   - 自动生成 release notes
   - 上传上述两个归档为 Release assets
```

### 打包内容

以 [`.github/workflows/release.yml`](../.github/workflows/release.yml) 为准：

| 包含 | 不包含（当前） |
|------|----------------|
| `smtgit.sh` | `.git/` |
| `shared/` | `.github/` |
| `docs/` | `RFCs/` |
| `README.md` | `.agents/` |
| `AGENTS.md` | `.cursor/` |

是否将 `RFCs/` 或 `.agents/rules/` 纳入发布归档，需维护者另行决定，并同步更新本文件与 workflow。

## 示例

```bash
# 在已推送到 origin 的提交上打 tag 并发布
git tag v0.1.0
git push origin v0.1.0
# 打开仓库 Releases 页查看产物与说明
```

## 相关代码

| 文件 | 职责 |
|------|------|
| [`.github/workflows/release.yml`](../.github/workflows/release.yml) | tag 触发、打包、创建 Release |
