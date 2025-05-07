import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrms/core/constants/app_colors.dart';
import 'package:hrms/domain/entities/email_draft.dart';
import 'package:hrms/presentation/bloc/email/email_bloc.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Drafts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<EmailBloc>().add(LoadEmails()),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<EmailBloc, EmailState>(
        builder: (context, state) {
          if (state is EmailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EmailError) {
            return Center(child: Text(state.message));
          }

          if (state is EmailLoaded) {
            return _buildEmailList(context, state.emails);
          }

          return const Center(child: Text('No emails found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.email),
        onPressed: () => _showComposeDialog(context),
        tooltip: 'Compose Email',
      ),
    );
  }

  Widget _buildEmailList(BuildContext context, List<EmailDraft> emails) {
    return ListView.separated(
      separatorBuilder: (context, index) => SizedBox(height: 10,),
      padding: const EdgeInsets.all(16),
      itemCount: emails.length,
      itemBuilder: (context, index) {
        final email = emails[index];
        return Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(16),
   color: AppColors.white,border: Border.all(color:Colors.grey.shade300 )),         
         
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            title: Text(
              email.subject,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'To: ${email.recipient}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  email.body.length > 100
                      ? '${email.body.substring(0, 100)}...'
                      : email.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => context.read<EmailBloc>().add(
                    DeleteEmail(email.id!),
                  ),
              color: Colors.red[400],
            ),
            onTap: () => _showEmailDetailsDialog(context, email),
          ),
        );
      },
    );
  }

  void _showComposeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const EmailComposeDialog();
      },
    );
  }

  void _showEmailDetailsDialog(BuildContext context, EmailDraft email) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(email.subject),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'To: ${email.recipient}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  email.body,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class EmailComposeDialog extends StatefulWidget {
  const EmailComposeDialog({super.key});

  @override
  State<EmailComposeDialog> createState() => _EmailComposeDialogState();
}

class _EmailComposeDialogState extends State<EmailComposeDialog> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Compose Email',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _recipientController,
                decoration: const InputDecoration(
                  labelText: 'To',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Recipient is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 16,
                  ),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Message is required' : null,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Save Draft'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final email = EmailDraft(
        recipient: _recipientController.text,
        subject: _subjectController.text,
        body: _bodyController.text,
        imagePaths: [],
      );
      context.read<EmailBloc>().add(AddEmail(email));
      Navigator.pop(context);
    }
  }
}