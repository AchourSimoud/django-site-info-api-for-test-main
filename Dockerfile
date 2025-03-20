# Utiliser une image légère de Python
FROM python:3.11-slim  

# Définir les variables d'environnement pour éviter les fichiers .pyc et activer le logging
ENV PYTHONDONTWRITEBYTECODE=1  
ENV PYTHONUNBUFFERED=1  

# Définir le répertoire de travail
WORKDIR /app  

# Copier et installer les dépendances avant d'ajouter le code source (meilleur cache Docker)
COPY requirements.txt .  
RUN python -m pip install --no-cache-dir -r requirements.txt  

# Copier le projet sauf la base de données (elle sera stockée ailleurs)
COPY ./myproject /app  

# Exposer le port de l’application Django
EXPOSE 9091  

# Créer un script de lancement avec migration
CMD ["sh", "-c", "python manage.py migrate && python manage.py runserver 0.0.0.0:9091"]
