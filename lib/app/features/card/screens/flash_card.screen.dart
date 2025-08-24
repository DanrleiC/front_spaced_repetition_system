import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_spaced_repetition_system/app/default_widgets/custom_textfield.widget.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_deck.dart';
import 'package:front_spaced_repetition_system/app/features/card/models/flash_card_form.dart';
import 'package:front_spaced_repetition_system/app/features/card/providers/flash_card.api.dart';
import 'package:front_spaced_repetition_system/app/features/card/widget/preview.dart';
import 'package:front_spaced_repetition_system/app/features/homepage/models/deck.model.dart';
import 'package:front_spaced_repetition_system/app/utils/colors_app.dart';

class FlashcardCreatorScreen extends ConsumerStatefulWidget {
  const FlashcardCreatorScreen({super.key});

  @override
  ConsumerState<FlashcardCreatorScreen> createState() => _FlashcardCreatorScreenState();
}

class _FlashcardCreatorScreenState extends ConsumerState<FlashcardCreatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _deckNameController = TextEditingController();
  final _deckDescriptionController = TextEditingController();
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  DeckModel? _receivedDeckModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_receivedDeckModel == null) {
      final DeckModel? deckModel = ModalRoute.of(context)?.settings.arguments as DeckModel?;

      if (deckModel != null) {
        _receivedDeckModel = deckModel;
        _deckNameController.text = deckModel.name;
        _deckDescriptionController.text = deckModel.description;

        _loadFlashcards(deckModel.id);
      }
    }
  }

  void _loadFlashcards(String deckId) async {
    final flashcardDeckNotifier = ref.read(flashcardDeckProvider.notifier);
    
    final asyncCards = await ref.read(flashcardsProvider(deckId).future);
    
    flashcardDeckNotifier.setCards(asyncCards);
  }

  @override
  void dispose() {
    _deckNameController.dispose();
    _deckDescriptionController.dispose();
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }
  
  void _addOrUpdateCard() {
    final formState = ref.read(flashcardFormProvider);
    
    if (!formState.canSave) {
      _showSnackBar('Pergunta e resposta são obrigatórias', isError: true);
      return;
    }

    final card = ref.read(flashcardFormProvider.notifier).createCard();
    
    if (formState.isEditing) {
      ref.read(flashcardDeckProvider.notifier).updateCard(card);
      _showSnackBar('Card atualizado!');
    } else {
      ref.read(flashcardDeckProvider.notifier).addCard(card);
      _showSnackBar('Card adicionado!');
    }

    ref.read(flashcardFormProvider.notifier).clearForm();
    _questionController.clear();
    _answerController.clear();
  }

  void _editCard(Flashcard card) {
    ref.read(flashcardFormProvider.notifier).loadCardForEditing(card);
    _questionController.text = card.question;
    _answerController.text = card.answer;
  }

  void _deleteCard(String cardId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ColorsApp.cardBackgound,
        title: const Text('Excluir Card'),
        content: const Text('Tem certeza que deseja excluir este card?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref.read(flashcardDeckProvider.notifier).removeCard(cardId);
              Navigator.pop(context);
              _showSnackBar('Card excluído!');
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _finalizeDeck() {
    final deck = ref.read(flashcardDeckProvider);
    
    if (deck.name.isEmpty) {
      _showSnackBar('Salve as informações do deck primeiro', isError: true);
      return;
    }
    
    if (deck.isEmpty) {
      _showSnackBar('Adicione pelo menos um card', isError: true);
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Finalizar Deck'),
        content: Text(
          'Deck "${deck.name}" criado com ${deck.cardCount} cards.\n\nDeseja finalizar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continuar Editando'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, deck);
            },
            child: const Text('Finalizar'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deck = ref.watch(flashcardDeckProvider);
    final formState = ref.watch(flashcardFormProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Deck e Cards'),
        backgroundColor: ColorsApp.cardBackgound,
        foregroundColor: ColorsApp.freedom,
        elevation: 0,
      ),
      backgroundColor: ColorsApp.background,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDeckInfoSection(),
              const SizedBox(height: 32),
              _buildCardPreviewSection(formState),
              const SizedBox(height: 32),
              _buildCardListSection(deck),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeckInfoSection() {
    return Card(
      color: ColorsApp.cardBackgound,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informações do Deck',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextField(
              readOnly: true,
              label: 'Nome do Deck',
              controller: _deckNameController,
              prefixIcon: Icon(Icons.title, color: ColorsApp.labelField),
            ), 
            const SizedBox(height: 16),
            CustomTextField(
              readOnly: true,
              label: 'Descrição',
              controller: _deckDescriptionController,
              prefixIcon: Icon(Icons.description, color: ColorsApp.labelField)
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPreviewSection(FlashcardFormState formState) {
    return Card(
      color: ColorsApp.cardBackgound,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  formState.isEditing ? 'Editar Card' : 'Criar Novo Card',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (formState.isEditing) ...[
                  const SizedBox(width: 8),
                  Chip(
                    label: const Text('Editando'),
                    backgroundColor: Colors.orange.shade100,
                    labelStyle: TextStyle(color: Colors.orange.shade800),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 800) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildFrontCard(formState)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildBackCard(formState)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildFrontCard(formState),
                      const SizedBox(height: 16),
                      _buildBackCard(formState),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 16),

            CustomTextField(
              controller: _questionController,
              label: 'Pergunta',
              maxLines: 2,
              prefixIcon: Icon(Icons.help_outline, color: ColorsApp.labelField,),
              onChanged: (value) {
                ref.read(flashcardFormProvider.notifier).updateQuestion(value);
              },
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller: _answerController, 
              label: 'Resposta',
              maxLines: 3,
              onChanged: (value) {
                ref.read(flashcardFormProvider.notifier).updateAnswer(value);
              },
              prefixIcon: Icon(Icons.lightbulb_outline, color: ColorsApp.labelField,)
            ),
        
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: formState.canSave ? _addOrUpdateCard : null,
                icon: Icon(formState.isEditing ? Icons.update : Icons.add),
                label: Text(formState.isEditing ? 'Atualizar Card' : 'Adicionar Card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontCard(FlashcardFormState formState) {
    return FlashcardPreviewWidget(
      title: 'Frente',
      content: formState.question,
      media: formState.frontMedia,
      onAddImage: () => ref.read(flashcardFormProvider.notifier).pickFrontImage(),
      onRemoveImage: () => ref.read(flashcardFormProvider.notifier).removeFrontImage(),
    );
  }

  Widget _buildBackCard(FlashcardFormState formState) {
    return FlashcardPreviewWidget(
      title: 'Trás',
      content: formState.answer,
      media: formState.backMedia,
      showAudioOption: true,
      onAddImage: () => ref.read(flashcardFormProvider.notifier).pickBackImage(),
      onAddAudio: () => ref.read(flashcardFormProvider.notifier).pickBackAudio(),
      onRemoveImage: () => ref.read(flashcardFormProvider.notifier).removeBackImage(),
      onRemoveAudio: () => ref.read(flashcardFormProvider.notifier).removeBackAudio(),
    );
  }

  Widget _buildCardListSection(FlashcardDeck deck) {
    final asyncState = ref.watch(flashcardsProvider(_receivedDeckModel!.id));

    return Card(
      color: ColorsApp.cardBackgound,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cards Criados',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (deck.isNotEmpty)
                  Chip(
                    label: Text(
                      '${deck.cardCount} cards',
                      style: TextStyle(
                        color: ColorsApp.labelField,
                      ),
                    ),
                    backgroundColor: ColorsApp.cardBackgound,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            
            asyncState.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Erro ao carregar cards: $error',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              data: (_) {
                
                if (deck.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: ColorsApp.fieldBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ColorsApp.borderField),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.style_outlined,
                          size: 48,
                          color: ColorsApp.labelField,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum card criado ainda',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: ColorsApp.labelField,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Crie seu primeiro card preenchendo os campos acima',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorsApp.labelField,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: deck.cards.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final card = deck.cards[index];
                      return _buildCardListItem(card, index, deck.cards.length);
                    },
                  );
                }
              },
            ),
            
            if (deck.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _finalizeDeck,
                  icon: const Icon(Icons.check_circle),
                  label: const Text('Finalizar Deck'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.mainPurple,
                    foregroundColor: ColorsApp.freedom,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardListItem(Flashcard card, int index, int totalCards) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsApp.borderField),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ColorsApp.fieldBackground,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              color: ColorsApp.mainPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          card.question,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: ColorsApp.labelField
          ),
        ),
        subtitle: Wrap(
          spacing: 4,
          children: [
            if (card.frontMedia.any((m) => m.isImage))
              Chip(
                label: const Text('Img F'),
                backgroundColor: Colors.blue.shade50,
                labelStyle: TextStyle(
                  color: Colors.blue.shade700,
                  fontSize: 10,
                ),
              ),
            if (card.backMedia.any((m) => m.isImage))
              Chip(
                label: const Text('Img T'),
                backgroundColor: Colors.green.shade50,
                labelStyle: TextStyle(
                  color: Colors.green.shade700,
                  fontSize: 10,
                ),
              ),
            if (card.backMedia.any((m) => m.isAudio))
              Chip(
                label: const Text('Audio'),
                backgroundColor: Colors.orange.shade50,
                labelStyle: TextStyle(
                  color: Colors.orange.shade700,
                  fontSize: 10,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => _editCard(card),
              tooltip: 'Editar',
            ),
            IconButton(
              icon: const Icon(Icons.delete, size: 20, color: Colors.red),
              onPressed: () => _deleteCard(card.id),
              tooltip: 'Excluir',
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_up, size: 20),
              onPressed: index > 0
                  ? () => ref.read(flashcardDeckProvider.notifier).moveCardUp(index)
                  : null,
              tooltip: 'Mover para cima',
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_down, size: 20),
              onPressed: index < totalCards - 1
                  ? () => ref.read(flashcardDeckProvider.notifier).moveCardDown(index)
                  : null,
              tooltip: 'Mover para baixo',
            ),
          ],
        ),
      ),
    );
  }
}
