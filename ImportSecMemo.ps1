Param($Path, $MemoTitol, $MemoValue, $Vault)

# $Path 		: CSV Path
# $MemoTitol	: タイトル列の名前
# $MemoValue	: メモ内容列の名前
# $Vault		: 保存先の保管庫名

if($Path -eq $null){
	Write-Output "The path cannot be omitted."
	exit
}

if($MemoTitol -eq $null){
	$MemoTitol = 'メモの名前'
}

if($MemoValue -eq $null){
	$MemoValue = 'メモの内容'
}

# カテゴリに「セキュアノート」を指定
$Category = 'Secure Note'

if(-not (Test-Path $Path)){
	Write-Output "$Path not found."
	exit
}
$SecMemos = Import-Csv $Path

foreach( $SecMemo in $SecMemos){
	$Titol = $SecMemo.$MemoTitol
	if( $Titol -eq [string]$null){
		$Titol = 'No Titol'
	}

	$Value = $SecMemo.$MemoValue
	if( $Value -eq [string]$null){
		$Value = 'No data'
	}

	if( $Vault -eq $null ){
		op item create --category $Category --title $Titol notesPlain=$Value
	}
	else{
		op item create --category $Category --Vault $Vault --title $Titol notesPlain=$Value
	}
}


