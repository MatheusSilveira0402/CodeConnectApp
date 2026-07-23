# Setup do Firebase para o pipeline de CI/CD

Checklist para destravar os jobs `build_and_distribute` e `test_lab` do
`.github/workflows/main.yml`. Esses jobs só rodam quando uma **tag** é
enviada ao repositório (`git tag v1.0.0 && git push origin v1.0.0`).

## 1. Projeto Firebase

- [x] Projeto criado em [console.firebase.google.com](https://console.firebase.google.com)
- [ ] App Android cadastrado no projeto:
  - Configurações do projeto (⚙) → aba **"Seus apps"** → **Adicionar app → Android**
  - Package name: `com.example.code_connect` (o `applicationId` atual em `android/app/build.gradle.kts`)
  - Não precisa baixar/adicionar o `google-services.json` — o app não usa nenhum SDK do Firebase, só a distribuição externa dos builds

## 2. Firebase App Distribution

- [ ] No menu lateral: **Release & Monitor → App Distribution → Introdução/Get started** (gratuito, ativa na hora)
- [ ] Aba **"Testers e grupos"** → **Adicionar grupo** → nome `testers` (tem que bater com `groups: testers` no `main.yml`) → adicionar e-mails dos testadores

## 3. Firebase Test Lab

- [ ] Requer o projeto estar no plano **Blaze** (pay-as-you-go). Tem cota diária gratuita de testes físicos/virtuais, mas precisa de cartão cadastrado no projeto (é do Firebase/GCP, separado da conta de billing do GitHub)
- [ ] Upgrade em: **Configurações do projeto → Uso e faturamento → Detalhes e configurações → Modificar plano → Blaze**
- [ ] Não precisa habilitar nada manualmente além disso — o comando `gcloud firebase test android run` já usa o Test Lab assim que o Blaze estiver ativo

## 4. Service Account (autenticação do GitHub Actions)

1. No [Google Cloud Console](https://console.cloud.google.com) (mesmo projeto do Firebase): **IAM e administrador → Contas de serviço → Criar conta de serviço**
2. Nome sugerido: `github-actions-ci`
3. Conceder os papéis:
   - **Firebase App Distribution Admin**
   - **Firebase Test Lab Admin** (ou **API Test Lab Admin**)
4. Depois de criada, na aba **"Chaves"** da conta de serviço → **Adicionar chave → Criar nova chave → JSON** → baixa o arquivo
5. **Não commitar esse arquivo no repositório.** Ele vai direto pro GitHub Secrets (próximo passo)

## 5. Pegar o App ID

- **Configurações do projeto → aba "Seus apps"** → no card do app Android, o **App ID** aparece no formato `1:123456789:android:abcdef1234567890`

## 6. Cadastrar os GitHub Secrets

No repositório: **Settings → Secrets and variables → Actions → New repository secret**

| Secret | Valor |
|---|---|
| `FIREBASE_APP_ID` | O App ID do passo 5 |
| `FIREBASE_SERVICE_ACCOUNT` | Conteúdo **inteiro** do JSON baixado no passo 4 (cola o JSON completo) |
| `FIREBASE_PROJECT_ID` | O ID do projeto Firebase (Configurações do projeto → "ID do projeto") |

⚠️ Nunca colar essas chaves direto no `main.yml` ou em qualquer arquivo versionado — só via Secrets.

## 7. Disparar o pipeline de release

Depois de tudo configurado:

```bash
git tag v1.0.0
git push origin v1.0.0
```

Isso dispara `build_and_distribute` (build release + upload pro App Distribution) e, em seguida, `test_lab` (Robo Test no Firebase Test Lab — o pipeline falha se o Test Lab reportar crash).
