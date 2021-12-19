/////////////////////////////////////////////////////////////////////////////
{
    Unit Format
    Criação: 99 Coders (Heber Stein Mazutti - heber@99coders.com.br)
    Versão: 1.2
}
/////////////////////////////////////////////////////////////////////////////

unit ContasAPagar.Diversos.Formatar;

interface

uses
  System.SysUtils,
  FMX.Edit,
  Classes,
  System.MaskUtils,
  ContasAPagar.Diversos.Enumerados;

procedure Formatar(Obj: TObject; Formato : TFormato; Extra : string = '');

implementation

function SomenteNumero(str : string) : string;
var
  iContador : integer;
begin
  Result := EmptyStr;
  for iContador := 0 to Length(str) - 1 do
  begin
    if (CharInSet(str.Chars[iContador],['0'..'9'])) then
    begin
      Result := Result + str.Chars[iContador];
    end;
  end;
end;

function FormataValor(str : string) : string;
begin
  if Str = '' then
  begin
    Str := '0';
  end;

  try
    Result := FormatFloat('#,##0.00', strtofloat(str) / 100);
  except
    Result := FormatFloat('#,##0.00', 0);
  end;
end;

function FormataPeso(str : string) : string;
begin
  if Str.IsEmpty then
  begin
    Str := '0';
  end;

  try
    Result := FormatFloat('#,##0.000', strtofloat(str) / 1000);
  except
    Result := FormatFloat('#,##0.000', 0);
  end;
end;

function Mask(Mascara, Str : string) : string;
var
  iCaracter : Integer;
  iContador : integer;
begin
  iContador := 0;
  Result := EmptyStr;

  if Str.IsEmpty then
  begin
    exit;
  end;

  for iCaracter := 0 to Length(Mascara) - 1 do
  begin
    if Mascara.Chars[iCaracter] = '#' then
    begin
      Result := Result + Str.Chars[iContador];
      inc(iContador);
    end
    else
    begin
      Result := Result + Mascara.Chars[iCaracter];
    end;

    if iContador = Length(Str) then
      break;
  end;
end;

function FormataIE(Num, UF: string): string;
var
  Mascara : string;
begin
  Mascara := '';
  IF UF = 'AC' Then Mascara := '##.###.###/###-##';
  IF UF = 'AL' Then Mascara := '#########';
  IF UF = 'AP' Then Mascara := '#########';
  IF UF = 'AM' Then Mascara := '##.###.###-#';
  IF UF = 'BA' Then Mascara := '######-##';
  IF UF = 'CE' Then Mascara := '########-#';
  IF UF = 'DF' Then Mascara := '###########-##';
  IF UF = 'ES' Then Mascara := '#########';
  IF UF = 'GO' Then Mascara := '##.###.###-#';
  IF UF = 'MA' Then Mascara := '#########';
  IF UF = 'MT' Then Mascara := '##########-#';
  IF UF = 'MS' Then Mascara := '#########';
  IF UF = 'MG' Then Mascara := '###.###.###/####';
  IF UF = 'PA' Then Mascara := '##-######-#';
  IF UF = 'PB' Then Mascara := '########-#';
  IF UF = 'PR' Then Mascara := '########-##';
  IF UF = 'PE' Then Mascara := '##.#.###.#######-#';
  IF UF = 'PI' Then Mascara := '#########';
  IF UF = 'RJ' Then Mascara := '##.###.##-#';
  IF UF = 'RN' Then Mascara := '##.###.###-#';
  IF UF = 'RS' Then Mascara := '###/#######';
  IF UF = 'RO' Then Mascara := '###.#####-#';
  IF UF = 'RR' Then Mascara := '########-#';
  IF UF = 'SC' Then Mascara := '###.###.###';
  IF UF = 'SP' Then Mascara := '###.###.###.###';
  IF UF = 'SE' Then Mascara := '#########-#';
  IF UF = 'TO' Then Mascara := '###########';

  Result := Mask(mascara, Num);
end;

function FormataData(str : string): string;
begin
  str := Copy(str, 1, 8);

  if Length(str) < 8 then
    Result := Mask('##/##/####', str)
  else
  begin
    try
      str := Mask('##/##/####', str);
      strtodate(str);
      Result := str;
    except
      Result := EmptyStr;
    end;
  end;
end;

procedure Formatar(Obj: TObject; Formato : TFormato; Extra : string = '');
var
  texto : string;
begin
  TThread.Queue(Nil, procedure
  begin
    if obj is TEdit then
    begin
      texto := TEdit(obj).Text;
    end;

    case formato of
      CNPJ              : texto := Mask('##.###.###/####-##', SomenteNumero(texto));
      CPF               : texto := Mask('###.###.###-##', SomenteNumero(texto));
      InscricaoEstadual : texto := FormataIE(SomenteNumero(texto), Extra);
      TelefoneFixo      : texto := Mask('(##) ####-####', SomenteNumero(texto));
      Celular           : texto := Mask('(##) #####-####', SomenteNumero(texto));
      Personalizado     : texto := Mask(Extra, SomenteNumero(texto));
      Valor             : texto := FormataValor(SomenteNumero(texto));
      CEP               : Mask('##.###-###', SomenteNumero(texto));
      Dt                : texto := FormataData(SomenteNumero(texto));
      Peso              : texto := FormataPeso(SomenteNumero(texto));
      CNPJorCPF:
      begin
        if Length(SomenteNumero(texto)) <= 11 then
        begin
          texto := Mask('###.###.###-##', SomenteNumero(texto));
        end
        else
        begin
          texto := Mask('##.###.###/####-##', SomenteNumero(texto));
        end;
      end;
      Money:
      begin
        if Extra = EmptyStr then
        begin
          Extra := 'R$';
        end;

        texto := Concat(Extra,' ',FormataValor(SomenteNumero(texto)));
      end;
    end;

    if obj is TEdit then
    begin
      TEdit(obj).Text := texto;
      TEdit(obj).CaretPosition := TEdit(obj).Text.Length;
    end;

  end);

end;

end.
