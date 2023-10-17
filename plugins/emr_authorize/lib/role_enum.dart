enum RoleEnum {
  register('REGISTER'),
  ticketSeller('TICKET_SELLER'),
  supervisor('SUPERVISOR'),
  tester('TESTER');

  const RoleEnum(this.roleCode);

  final String roleCode;
}
