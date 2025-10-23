// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:soulmatch/state/app_state.dart';
import 'package:soulmatch/theme.dart';
import 'package:soulmatch/widgets/ai_date_popup.dart'; // Предполагаем, что создали

class ChatScreen extends StatefulWidget {
  final UserProfile profile;
  final VoidCallback onBack;

  const ChatScreen({super.key, required this.profile, required this.onBack});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Мок-данные сообщений
  final List<Map<String, String>> messages = [
    {'id': '1', 'text': "Привет! Я заметил(а), что ты тоже любишь художественные галереи 🎨", 'sender': 'them', 'time': '14:30'},
    {'id': '2', 'text': "Да! Я обожаю современное искусство. Ты был(а) в MoMA?", 'sender': 'me', 'time': '14:32'},
    {'id': '3', 'text': "Был(а)! Это потрясающе. Нам стоит сходить на новую выставку как-нибудь", 'sender': 'them', 'time': '14:35'},
    {'id': '4', 'text': "Звучит здорово! С удовольствием пойду", 'sender': 'me', 'time': '14:36'},
  ];


  void _showAIPopup() {
    showDialog(
      context: context,
      builder: (context) => AIDatePopup(
        onAccept: () {
          Navigator.of(context).pop();
          // TODO: Handle accept
          setState(() {
             // Добавляем сообщение о принятии предложения в чат
             messages.add({
              'id': '${messages.length + 1}',
              'text': "Sounds like a plan! Let's go to the theater.",
              'sender': 'me',
              'time': 'Now' // Примерное время
             });
          });
          _scrollToBottom();
        },
        onLater: () => Navigator.of(context).pop(),
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

   void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add({
          'id': '${messages.length + 1}',
          'text': text,
          'sender': 'me',
          'time': 'Now' // Или реальное время
        });
      });
      _messageController.clear();
      _scrollToBottom();
      // TODO: Добавить логику отправки сообщения на сервер
    }
  }

  void _scrollToBottom() {
    // Небольшая задержка, чтобы ListView успел обновиться
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Прокрутка к последнему сообщению при открытии экрана
     WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        scrolledUnderElevation: 1, // Тень при скролле
        leading: IconButton(
          icon: const Icon(LucideIcons.chevronLeft, color: AppTheme.mutedForeground),
          onPressed: widget.onBack,
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.profile.image),
              radius: 20, // w-10/2
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.profile.name, style: textTheme.headlineSmall),
                Row(
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(
                        color: Colors.green, // bg-green-500
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text('Online', style: textTheme.bodySmall?.copyWith(color: AppTheme.mutedForeground)),
                  ],
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[200], height: 1.0), // border-b
        ),
      ),
      body: Column(
        children: [
          // AI Suggestion Banner
          _buildAISuggestionBanner(),
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg['sender'] == 'me';
                return _buildMessageBubble(
                  context,
                  text: msg['text']!,
                  time: msg['time']!,
                  isMe: isMe,
                );
              },
            ),
          ),
          // Input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildAISuggestionBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // px-6 py-4
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppTheme.pink50, AppTheme.purple50]),
        border: Border(bottom: BorderSide(color: AppTheme.purple50.withAlpha(200))), // border-b border-purple-100
      ),
      child: GestureDetector(
        onTap: _showAIPopup,
        child: Container(
          padding: const EdgeInsets.all(12), // p-3
          decoration: BoxDecoration(
            color: AppTheme.background,
            borderRadius: BorderRadius.circular(16), // rounded-2xl
            border: Border.all(color: AppTheme.purple50.withAlpha(200)), // border-purple-200
          ),
          child: Row(
            children: [
              Container(
                width: 40, height: 40, // w-10 h-10
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppTheme.primaryGradient,
                ),
                child: const Icon(LucideIcons.sparkles, size: 20, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ИИ придумал идею для свидания!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Нажмите, чтобы увидеть предложение',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppTheme.mutedForeground),
                      ),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, {required String text, required String time, required bool isMe}) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.only(
      topLeft: isMe ? const Radius.circular(24) : const Radius.circular(6),
      topRight: isMe ? const Radius.circular(6) : const Radius.circular(24),
      bottomLeft: const Radius.circular(24),
      bottomRight: const Radius.circular(24),
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // px-4 py-3
        decoration: BoxDecoration(
          borderRadius: borderRadius, // rounded-3xl rounded-tr/tl-md
          gradient: isMe ? AppTheme.primaryGradient : null,
          color: isMe ? null : Colors.grey[100], // bg-gray-100
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe ? Colors.white : AppTheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: theme.textTheme.labelSmall?.copyWith(
                color: isMe ? Colors.white70 : AppTheme.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(
        color: AppTheme.background,
        border: Border(top: BorderSide(color: Colors.grey[200]!)), // border-t
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Введите сообщение...',
                contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16), // h-12 px-6
                // Убираем border из темы, используем fillColor
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              minLines: 1,
              maxLines: 5, // Позволяем вводить несколько строк
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48, height: 48, // w-12 h-12
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppTheme.primaryGradient,
            ),
            child: IconButton(
              icon: const Icon(LucideIcons.send, size: 20, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
