$release = Get-Content release

#Build-args padrões.
$BUILD_DATE = [Xml.XmlConvert]::ToString((get-date),[Xml.XmlDateTimeSerializationMode]::Utc)
$VCS_REF = "367769da361526411ffac12dae5fa19bb87c3f6c"
$BUILD_VERSION = Get-Content build
$tag = ($release + ":" + $BUILD_VERSION)

Write-Host "Iniciando Build..."

try {

    
    docker build -t $tag --build-arg BUILD_DATE=$BUILD_DATE `
                         --build-arg VCS_REF=$VCS_REF `
                         --build-arg BUILD_VERSION=$BUILD_VERSION . 

}

catch {

    $ErrorMessage = $_.Exception.Message
    Write-Host "Erro na fase de build."
    Write-Host $ErrorMessage
    break
}

finally {

    Write-Host "A build foi um sucesso!"

}

Write-Host "Iniciando Push..."

try {

    #docker push $tag

}

catch {

    $ErrorMessage = $_.Exception.Message
    Write-Host "Erro na fase de push."
    Write-Host $ErrorMessage
    break
}

finally {

    Write-Host "O push foi um sucesso!"

}

Write-Host "Incrementando build ver para a próxima build."

[int]$BuildAtual = Get-Content build
$BuildAtual++
$BuildAtual > build