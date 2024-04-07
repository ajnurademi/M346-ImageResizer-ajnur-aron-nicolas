# M346-Projekt-Bilderverkleinern
---

## 📖 Beschreibung 
Das Ziel des Projekts im Modul M346 besteht darin, die Funktionalität zu entwickeln, mit der ein Bild in seinem ursprünglichen Format in die Cloud hochgeladen wird. Diese Aufgabe wird mithilfe der Amazon Web Services (AWS) Plattform erreicht, indem speziell die Dienste Amazon S3 (Simple Storage Service) und AWS Lambda eingesetzt werden.

Amazon S3 dient als Speicherdienst in der Cloud, der es ermöglicht, große Mengen an Daten, einschliessich Bilddateien, sicher und zuverlässig zu speichern. Lambda hingegen ist ein serverloser Bereitstellungsdienst, der es ermöglicht, Code auszuführen, ohne sich um die Verwaltung von Servern kümmern zu müssen.

Durch die Verwendung von S3 und Lambda kann das Projekt automatisiert werden, um den Upload von Bildern zu erleichtern.

## 📃 Dokumenatation 
Die tatsächliche Dokumentation unseres Projekts bzw. Repositories ist unter diesem Link zugänglich: [**Dokumentation M346-ImageResizer-ajnur-aron-nicolas**](https://ajnurademi.github.io/M346-ImageResizer-ajnur-aron-nicolas/).

WICHTIGE MELDUNG: Wenn die aktuelle Version der Dokumentation nicht online angezeigt wird, dann löschen sie den 'Cache' ihres Browser und rufen Sie den oberigen LINK nochmals auf.

## 🚩 Ziele
Das Hauptziel des Projekts ist es, ...
* **Aufsetzen eines funktionstüchtigen Cloud-Services:** Implementierung eines Services in der Cloud gemäss den Projektanforderungen.
* **Implementierung als Infrastructure as Code (IaC):** Gestaltung der gesamten Infrastruktur als Code für einfache Bereitstellung und Verwaltung in der Cloud.
* **Dokumentation in Git und Markdown:** Erstellung der Projektdokumentation direkt über Git in Markdown-Format für eine einfache Verwaltung und Integration.
* **Durchführung und Protokollierung von Testfällen:** Definieren und Durchführen von Testfällen zur Gewährleistung der Funktionalität des Services und Protokollierung der Ergebnisse.


## 🔧 Funktionsweise
Das Skript verwendet die AWS CLI, um das Bild in S3 hochzuladen. Anschließend wird ein Lambda-Funktionstrigger ausgelöst, der weitere Aktionen ausführt, wie z.B. Bildbearbeitung oder Verschieben in andere S3-Buckets.

## 👨‍💻 Beitragende
- [Ajnur Ademi](https://github.com/ajnurademi)
- [Aron Herbel](https://github.com/aronherbel)
- [Nicolas Haas](https://github.com/cpowern)

## 📜 Lizenz
Dieses Projekt ist unter der MIT-Lizenz frei zugänglich. Weitere Informationen finden Sie in der [Lizenzdatei](/M346-ImageResizer-ajnur-aron-nicolas/LICENCE.md).
