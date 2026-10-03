# Trainingspartner 2.0

Fullscreen timer voor een training met bokszak, barbell en losse gewichten (ongeveer 60 minuten).

- Grote oefeningnaam, aftelklok en een balk die leegloopt
- Rood voor boksen, oranje voor overige oefeningen, blauw voor rust
- Rechts de drie eerstvolgende oefeningen met hun duur
- Automatisch 10 sec materiaalpauze bij een directe wissel tussen boksen en overige oefeningen
- Volgorde zo dat de handschoenen maar één keer aan en uit gaan
- Knoppen voor vorige oefening, start/pauze en volgende oefening
- Piepjes in de laatste 3 seconden en bij elke wissel
- Live hartslag van een Fitbit Air (of andere Bluetooth-hartslagmeter) met zones en grafiek van de laatste 5 minuten
- Toetsen: spatie = start/pauze, pijltjes = vorige/volgende

Open `index.html` in een browser, of zet GitHub Pages aan voor deze repository.

## Hartslag verbinden

1. Zet op je Fitbit Air in Google Health bij Connections **Share heart rate** aan (en eventueel **Always visible**).
2. Open de timer in Chrome of Edge op Android, Windows, Mac of Chromebook. Safari op iPhone/iPad ondersteunt geen Web Bluetooth.
3. Tik op **Verbind hartslag** en kies je Fitbit Air.
4. Stel onderin je maximale hartslag in; de zones (60/70/80/90%) worden daarop berekend.

## Trainingen opslaan (Supabase)

Elke training wordt na afloop opgeslagen: duur, hartslag per oefening (gemiddeld en max) en de volledige hartslagreeks. Zonder internet blijft een training in Chrome in de wachtrij staan en wordt later alsnog geupload.

Eenmalige opzet:

1. Maak een Supabase-project aan.
2. Open **SQL Editor**, plak de inhoud van `supabase/schema.sql` en klik **Run**.
3. Ga naar **Authentication > Users > Add user** en maak een gebruiker met e-mail en wachtwoord. Zet daarna bij **Authentication > Sign In / Providers** "Allow new users to sign up" uit, zodat niemand anders een account kan maken.
4. Kopieer bij **Project Settings > API** de Project URL en de publishable key naar `config.js` (of vul ze in de timer in via **Trainingsdata > Supabase-koppeling**).
5. Open de timer, klik op **Trainingsdata** en log in.
