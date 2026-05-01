# Script Rules

## 1. 문서 목적

이 문서는 `specdrive/scripts/**` 아래 script 자산의 운영 규칙을 정의한다.

script는 SpecDrive Core 흐름을 보조하는 실행 자산이며, 문서 기준과 config 기준을 침범하지 않아야 한다.

---

## 2. 기본 원칙

- script는 가능한 한 `specdrive/config/**` 의 registry와 설정을 읽어 동작한다.
- script는 preview 생성과 실제 반영을 명확히 구분한다.
- 실제 문서 반영, history 저장, Git 전달 단위 생성은 개발자 승인 흐름과 연결되어야 한다.
- script 출력은 재현 가능하고 사람이 검토할 수 있어야 한다.
- script 변경 시 관련 문서와 config 변경 필요 여부를 함께 확인한다.

---

## 3. 출력 원칙

- 재생성 가능한 실행 산출물은 `.speclab/**` 아래에 둔다.
- 보존해야 하는 의미 있는 문서 이력은 `docs/history/**` 정책을 따른다.
- preview 출력은 현재 기준 문서를 대체하지 않는다.
- non-zero exit code가 있어도 산출 파일이 남을 수 있으므로, 필요한 경우 exit code와 출력 파일을 함께 확인한다.

---

## 4. 금지 사항

- script가 확정되지 않은 문서를 기준 문서처럼 반영하지 않는다.
- script가 config에 있는 책임을 하드코딩으로 대체하지 않는다.
- destructive action은 개발자 명시 요청 없이 실행하지 않는다.
- 현재 범위를 넘는 CLI/TUI/MCP 자동화를 조기 도입하지 않는다.

