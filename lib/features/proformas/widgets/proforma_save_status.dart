enum ProformaSaveStatus {
  idle,
  pending,
  saving,
  saved,
  error,
}

extension ProformaSaveStatusX on ProformaSaveStatus {
  String get label => switch (this) {
        ProformaSaveStatus.idle => '',
        ProformaSaveStatus.pending => 'Cambios…',
        ProformaSaveStatus.saving => 'Guardando…',
        ProformaSaveStatus.saved => 'Guardado',
        ProformaSaveStatus.error => 'Error al guardar',
      };
}
