FROM python:3.13-rc-alpine3.20


# Create non root user early for easy of build
# RUN adduser --system --no-create-home djangouser


WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1 

COPY requirements.txt .

RUN pip3 install -r requirements.txt #--no-cache-dir

COPY . .
	
EXPOSE 8000

# Set non root user for security, best for apps with external DB
# USER djangouser


ENTRYPOINT ["python3"] 
CMD ["manage.py", "runserver", "0.0.0.0:8000"]