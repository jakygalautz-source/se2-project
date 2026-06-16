Die Datenbank der App läuft über Docker Desktop, dadurch ist es wichtig das Programm Docker Desktop,
zum testen der App, lokal zu installieren und das Image des Backend zu erstellen.

Anleitung:
1. Nach Installation von Docker Desktop den Befehl "cd …/backend" ausführen
2. Danach das Image mit "docker compose up --build" erstellen
3. Wenn das Image erstellt wurde, den Befehl "docker compose up -d " ausführen um die Container zu starten
--optional--
Um die Images wieder zu löschen, kann der Befehl "docker compose down -v" ausgeführt werden.

Überprüfung der Datenbank:
Um zu testen ob die Datenbank die Werte übernimmt, müssen folgende Schritte durchgeführt werden:
1. Öffnen der PowerShell
2. Die Verbindung zur Datenbank erhält man mit dem Befehl "docker exec -it pill_pilot_postgres psql -U postgres -d pill_pilot"
3. Danach können die gewünschten SQL-Queries eingegeben werden. 
Bsp: 
SELECT id, username, email, created_at
FROM users
ORDER BY id DESC;
4. Mit dem Befehl "\l" werden alle Tables der Datenbank angezeigt
5. Um die Verbindung zur Datenbank wieder zu trennen, benutzt man die Befehl "\q"