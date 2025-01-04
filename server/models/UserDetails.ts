import mongoose from 'mongoose';

const userDetailsSchema = new mongoose.Schema({
  userId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
    unique: true
  },
  isEmployee: {
    type: Boolean,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  latitude: {
    type: Number,
    required: true
  },
  longitude: {
    type: Number,
    required: true
  },
  address: {
    type: String,
    required: true
  },
  imageLink: {
    type: String,
    default: ''
  },
  // Employee specific fields
  contactNumber: String,
  experiences: [{
    role: String,
    company: String,
    duration: String,
    location: String,
    description: String
  }],
  education: [{
    instituteName: String,
    duration: String,
    type: String,
    courseName: String
  }],
  skills: [String],
  desiredRoles: [String],
  extraCurriculars: String,
  achievements: String,
  portfolioLinks: String,
  // Employer specific fields
  companyName: String
}, {
  timestamps: true
});

// Sanitize input before saving
userDetailsSchema.pre('save', function(next) {
  const doc = this.toObject();
  for (const [key, value] of Object.entries(doc)) {
    if (typeof value === 'string') {
      this.set(key, value.trim());
    }
  }
  next();
});

export const UserDetails = mongoose.model('UserDetails', userDetailsSchema); 