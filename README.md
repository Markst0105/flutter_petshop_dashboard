# Painel do Funcionário de Pet Shop - Versão Flutter

Um aplicativo Flutter para funcionários de pet shops gerenciarem agendas, visualizarem compromissos e gerenciarem preços.

## Funcionalidades

- **Tela de Login**: Acesso fácil a diferentes seções do painel
- **Tela de Agenda**: Visualize os compromissos de hoje com informações detalhadas da reserva
- **Tela de Calendário**: Navegue pelos compromissos em diferentes datas
- **Tela Financeira**: Gerencie serviços e preços para diferentes portes de animais

## Estrutura do Projeto

```
lib/
├── main.dart                 # Ponto de entrada do aplicativo
├── providers/
│   └── app_state.dart       # Gerenciamento de estado com Provider
├── models/
│   ├── booking.dart         # Modelo de dados de reserva
│   └── service.dart         # Modelo de dados de serviço
├── screens/
│   ├── app.dart             # Estrutura principal do aplicativo
│   ├── login_screen.dart    # Tela de login/ponto de entrada
│   ├── schedule_screen.dart # Visualização da agenda de hoje
│   ├── calendar_screen.dart # Visualização do calendário
│   └── financial_screen.dart # Serviços e preços
└── widgets/
    ├── header.dart          # Cabeçalho do aplicativo com navegação
    └── booking_card.dart    # Cartão de detalhes da reserva
```

## Começando

### Pré-requisitos

- Flutter SDK 3.0.0 ou superior
- Dart SDK (vem com o Flutter)

### Instalação

1. **Clone o repositório** (ou extraia os arquivos)
   ```bash
   cd flutter_petshop_dashboard
   ```

2. **Obtenha as dependências**
   ```bash
   flutter pub get
   ```

3. **Execute o aplicativo**
   ```bash
   flutter run
   ```

   Para web:
   ```bash
   flutter run -d chrome
   ```

## Dependências

- **provider**: Gerenciamento de estado
- **intl**: Internacionalização (localidade em português)
- **table_calendar**: Widget de calendário
- **fl_chart**: Gráficos e diagramas (para futuras funcionalidades financeiras)
- **animations**: Transições suaves

## Principais Funcionalidades Implementadas

### Tela de Login
- Exibição do logotipo
- Botões de navegação para as seções de Agenda, Calendário e Financeiro
- Interface limpa com suporte ao idioma português

### Tela de Agenda
- Visualize as reservas de hoje
- Cartões de reserva expansíveis mostrando detalhes completos
- Indicadores de status (Próximo, Em Andamento, Concluído, Cancelado)
- Informações do animal e do proprietário
- Lista de procedimentos do serviço
- Seção de notas/comentários

### Tela de Calendário
- Visualização mensal do calendário
- Indicadores de densidade de compromissos
- Detalhes da data selecionada
- Contagem de compromissos para cada dia
- Formatação de data em português

### Tela Financeira
- Catálogo de serviços com preços para diferentes portes de animais
- Adicionar/remover serviços do total
- Cálculo do total em tempo real
- Seletor de porte do animal (Pequeno, Médio, Grande)
- Interface de gerenciamento de serviços

## Arquitetura

### Gerenciamento de Estado
Usa o pacote Provider para um gerenciamento de estado simples e eficiente:
- `AppState` - Gerencia o status de login e a navegação da tela atual

### Temas
- Material Design 3
- Esquema de cores azul combinando com o design original
- Layout responsivo usando Expanded e Flex

### Localização
- Formatação de data em português (Brasil) usando o pacote `intl`
- Todo o texto da interface em português

## Customização

### Alterando Dados Fictícios
- Reservas: Edite `lib/models/booking.dart`
- Serviços: Edite `lib/models/service.dart`
- Dados do calendário: Edite `_CalendarScreenState` em `lib/screens/calendar_screen.dart`

### Estilização
- Cores: Modifique `seedColor` em `lib/main.dart`
- Fontes: Adicione fontes personalizadas em `pubspec.yaml` and update `fontFamily`

## Melhorias Futuras

- Integração com backend para dados de compromissos reais
- Notificações push para compromissos futuros
- Galeria de fotos para animais de estimação
- Integração de pagamentos
- Análises e relatórios
- Suporte a múltiplos usuários
- Modo escuro
- Agendamento de compromissos pelo lado do cliente

## Compilando para Produção

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Licença

Este projeto é uma adaptação em Flutter do aplicativo original Pet Shop Dashboard em React.
