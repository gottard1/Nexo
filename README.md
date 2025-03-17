# Nexo

**Nexo** é um aplicativo iOS desenvolvido como um estudo sobre **modularização** e **Server-Driven UI (SDUI)**, utilizando uma API específica para a renderização dinâmica da interface. Além disso, o projeto simula algumas funcionalidades de um aplicativo bancário.

## 🚀 Objetivos do Projeto

- **Estudo de Modularização**: Organização do código em módulos independentes para facilitar a escalabilidade e manutenção.
- **Server-Driven UI (SDUI)**: Implementação de uma interface dinâmica baseada em dados fornecidos pela API.
- **Simulação de um App Bancário**: Implementação de algumas funcionalidades típicas de aplicativos financeiros.

## 🛠️ Tecnologias Utilizadas

- **Swift** → Linguagem principal do desenvolvimento.
- **UIKit** → Framework declarativo para construção da interface do usuário.
- **Async await** → Programação reativa para lidar com estados e eventos assíncronos.
- **Modularização** → Estruturação do projeto em módulos independentes.
- **Server-Driven UI (SDUI)** → Renderização de telas baseada em respostas da API.

## 📌 Estrutura do Projeto

A estrutura do projeto é organizada da seguinte forma:

- **Nexo/**
  - **Modules/**: Contém os módulos separados do projeto.
  - **SDUI/**: Implementação do sistema de renderização dinâmica da interface.
  - **Models/**: Definições das entidades e estruturas de dados utilizadas no app.
  - **Views/**: Interfaces e componentes visuais construídos com SwiftUI.
  - **ViewModels/**: Lógica de apresentação, conectando as Views aos Models.
  - **Services/**: Comunicação com a API e outras funções auxiliares.
  - **Resources/**: Arquivos de recursos, como assets e configurações.
  - **Supporting Files/**: Arquivos auxiliares do projeto, como `Info.plist`.

## 🔧 Configuração e Execução

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/gottard1/Nexo.git
   cd Nexo
   ```
2. **Abra o projeto no Xcode:**
   - Clique duas vezes no arquivo `Nexo.xcodeproj` ou `Nexo.xcworkspace`.
3. **Instale dependências (se aplicável):**
   - Se o projeto utilizar CocoaPods ou Swift Package Manager, certifique-se de instalar as dependências necessárias.
4. **Configure o esquema de execução:**
   - Selecione o dispositivo ou simulador desejado no Xcode.
5. **Compile e execute:**
   - Pressione `Cmd + R` ou clique no botão de execução no Xcode.

## 🧪 Testes

O projeto inclui testes automatizados para garantir a qualidade e a estabilidade do código.

- **Localização dos testes:**
  - Os testes estão localizados na pasta `NexoTests/`.
- **Execução dos testes:**
  - Para executar os testes, selecione o esquema de teste e pressione `Cmd + U` no Xcode.

## 📄 Licença

Este projeto está licenciado sob a [Nome da Licença]. Consulte o arquivo `LICENSE` para mais informações.

## 📞 Contato

Para mais informações ou suporte, entre em contato com [Seu Nome] em [seu.email@example.com].
